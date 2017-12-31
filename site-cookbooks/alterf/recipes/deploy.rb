#
# Cookbook Name:: alterf
# Recipe:: deploy
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
node[:alterf][:requirements].each do |package_name|
  package package_name do
    action :install
  end
end

deploy node[:alterf][:deploy_dir] do
  repo node[:alterf][:repository]
  branch ENV['ALTERF_VERSION'] || node[:alterf][:branch]
  action :deploy
  migrate false
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlink_before_migrate.clear
  symlinks node[:alterf][:symlinks]

  before_migrate do
    directory File.join(release_path, 'vendor')

    node[:alterf][:shared_dirs].each do |dir|
      directory File.join(release_path, "../../shared/#{dir}") do
        recursive true
      end
    end

    link File.join(release_path, 'vendor/bundle') do
      to File.join(release_path, '../../shared/bundle')
      link_type :symbolic
    end

    execute 'rvm 2.2.0 do bundle install --path=vendor/bundle' do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
      not_if { node.chef_environment == 'compute' }
    end

    node[:alterf][:mysql_users].each do |user|
      execute "mysql -u root -p#{node[:mysql][:root_password]} -e 'GRANT ALL PRIVILEGES ON *.* TO '#{user}'@'localhost';'"
    end
  end

  before_restart do
    template File.join(release_path, 'scripts/analyze/settings.yml') do
      source 'settings.yml.erb'
      owner 'root'
      group 'root'
      mode 0644
      only_if { %w[ compute development ].include?(node.chef_environment) }
    end

    execute 'rvm 2.2.0 do bundle exec rake resque:worker:restart' do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
      only_if { %w[ compute development ].include?(node.chef_environment) }
    end

    gmail = Chef::EncryptedDataBagItem.load('alterf', 'gmail')
    %w[ user_name password ].each do |user_info|
      execute "sed -i -e s/GMAIL_#{user_info.upcase}/#{gmail[user_info]}/g config/initializers/action_mailer.rb" do
        cwd release_path
        only_if { %w[ compute development ].include?(node.chef_environment) }
      end
    end

    execute 'rvm 2.2.0 do bundle exec rake assets:precompile' do
      cwd release_path
      environment 'RAILS_ENV' => 'production', 'PATH' => node[:rvm][:path], 'RAILS_RELATIVE_URL_ROOT' => "/#{node[:alterf][:app_name]}"
      only_if { node.chef_environment == 'compute' }
    end

    execute 'sed -i -e "s/<%= ENV\[\"SECRET_KEY_BASE\"\] %>/`rvm 2.2.0 do bundle exec rake secret`/g" config/secrets.yml' do
      cwd release_path
      environment 'RAILS_ENV' => 'production', 'PATH' => node[:rvm][:path]
      only_if { node.chef_environment == 'compute' }
    end
  end

  restart_command do
    execute 'rvm 2.2.0 do bundle exec rake unicorn:stop' do
      cwd release_path
      environment 'RAILS_ENV' => 'production', 'PATH' => node[:rvm][:path]
      only_if "pgrep -lf 'unicorn_rails.*#{node[:alterf][:app_name]}*'"
    end

    execute 'rvm 2.2.0 do bundle exec rake unicorn:start' do
      cwd release_path
      environment 'RAILS_ENV' => 'production', 'PATH' => node[:rvm][:path]
      only_if { %w[ compute development ].include?(node.chef_environment) }
    end
  end
end
