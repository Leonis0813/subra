#
# Cookbook Name:: regulus
# Recipe:: app
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
ruby_version = node[:regulus][:ruby_version]
rvm_do = "rvm #{ruby_version} do"

deploy node[:regulus][:deploy_dir] do
  repo node[:regulus][:repository]
  branch ENV['REGULUS_VERSION'] || node[:regulus][:branch]
  migrate true
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks node[:regulus][:symlinks]
  migration_command "#{rvm_do} bundle exec rake db:migrate"
  environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'),
              'PATH' => node[:rvm][:path]

  before_migrate do
    directory File.join(release_path, 'vendor')

    node[:regulus][:shared_dirs].each do |dir|
      directory File.join(node[:regulus][:deploy_dir], "shared/#{dir}") do
        recursive true
      end
    end

    link File.join(release_path, 'vendor/bundle') do
      to File.join(node[:regulus][:deploy_dir], 'shared/bundle')
    end

    execute "#{rvm_do} bundle install --path=vendor/bundle  --clean" do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end

    node[:regulus][:mysql_users].each do |user|
      mysql_query 'create grant' do
        query "GRANT ALL PRIVILEGES ON *.* TO '#{user}'@'localhost';"
        query_type 'string'
      end
    end

    execute "#{rvm_do} bundle exec rake db:create" do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'),
                  'PATH' => node[:rvm][:path]
    end

    execute 'sudo crontab -r' do
      only_if 'sudo crontab -l | grep "regulus"'
    end

    execute "#{rvm_do} bundle exec whenever --update-crontab" do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'),
                  'PATH' => node[:rvm][:path]
    end
  end

  before_restart do
    template File.join(release_path, 'scripts/settings.yml') do
      source 'settings.yml.erb'
      owner 'root'
      group 'root'
      mode '0644'
    end

    gmail = Chef::EncryptedDataBagItem.load('regulus', 'gmail')
    template File.join(release_path, 'config/initializers/action_mailer.rb') do
      source 'action_mailer.rb.erb'
      owner 'root'
      group 'root'
      mode '0644'
      variables(user_name: gmail['user_name'], password: gmail['password'])
    end

    execute "#{rvm_do} bundle exec rake resque:worker:restart" do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end

    execute "#{rvm_do} bundle exec rake assets:precompile" do
      cwd release_path
      environment 'RAILS_ENV' => 'production',
                  'PATH' => node[:rvm][:path],
                  'RAILS_RELATIVE_URL_ROOT' => "/#{node[:regulus][:app_name]}"
      only_if { %w[compute production].include?(node.chef_environment) }
    end
  end

  restart_command do
    execute "#{rvm_do} bundle exec rake unicorn:stop" do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'),
                  'PATH' => node[:rvm][:path]
      only_if "pgrep -lf 'unicorn_rails.*#{node[:regulus][:app_name]}*'"
    end

    execute "#{rvm_do} bundle exec rake unicorn:start" do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'),
                  'PATH' => node[:rvm][:path],
                  'SECRET_KEY_BASE' => SecureRandom.uuid
    end
  end
end
