#
# Cookbook Name:: alterf
# Recipe:: app
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
ruby_version = node[:alterf][:ruby_version]
rvm_do = "rvm #{ruby_version} do"

deploy node[:alterf][:deploy_dir] do
  repo node[:alterf][:repository]
  branch ENV['ALTERF_VERSION'] || node[:alterf][:branch]
  migrate true
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlink_before_migrate.clear
  symlinks node[:alterf][:symlinks]
  migration_command "#{rvm_do} bundle exec rake db:migrate"
  environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'),
              'PATH' => node[:rvm][:path]

  before_migrate do
    directory File.join(release_path, 'vendor')

    node[:alterf][:shared_dirs].each do |dir|
      directory File.join(node[:alterf][:deploy_dir], "shared/#{dir}") do
        recursive true
      end
    end

    link File.join(release_path, 'vendor/bundle') do
      to File.join(node[:alterf][:deploy_dir], 'shared/bundle')
    end

    execute "#{rvm_do} bundle install --path=vendor/bundle --clean" do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end

    node[:alterf][:mysql_users].each do |user|
      mysql_query 'create grant' do
        query "GRANT ALL PRIVILEGES ON *.* TO '#{user}'@'localhost';"
        query_type 'string'
      end
    end

    execute "#{rvm_do} bundle exec rake db:create" do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]
    end
  end

  before_restart do
    template File.join(release_path, 'config/settings.yml') do
      source 'settings.yml.erb'
      owner 'root'
      group 'root'
      mode '0644'
    end

    template File.join(release_path, 'config/denebola/database.yml') do
      source 'database.yml.erb'
      owner 'root'
      group 'root'
      mode '0644'
    end

    gmail = Chef::EncryptedDataBagItem.load('alterf', 'gmail')
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
                  'RAILS_RELATIVE_URL_ROOT' => "/#{node[:alterf][:app_name]}"
      only_if { node.chef_environment == 'compute' }
    end

    rake_command = "#{rvm_do} bundle exec rake secret"
    command = "sed -i -e 's/<%= ENV\[\"SECRET_KEY_BASE\"\] %>/`#{rake_command}`/g' " \
              'config/secrets.yml'
    execute command do
      cwd release_path
      environment 'RAILS_ENV' => 'production', 'PATH' => node[:rvm][:path]
      only_if { node.chef_environment == 'compute' }
    end
  end

  restart_command do
    execute "#{rvm_do} bundle exec rake unicorn:stop" do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'),
                  'PATH' => node[:rvm][:path]
      only_if "pgrep -lf 'unicorn_rails.*#{node[:alterf][:app_name]}*'"
    end

    execute "#{rvm_do} bundle exec rake unicorn:start" do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'),
                  'PATH' => node[:rvm][:path]
    end
  end
end
