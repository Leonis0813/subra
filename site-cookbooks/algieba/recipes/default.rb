#
# Cookbook Name:: algieba
# Recipe:: default
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
deploy node[:algieba][:deploy_dir] do
  repo node[:algieba][:repository]
  branch ENV['ALGIEBA_VERSION'] || node[:algieba][:branch]
  action :deploy
  migrate true
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlink_before_migrate.clear
  symlinks node[:algieba][:symlinks]
  migration_command 'rvm 2.2.0 do bundle exec rake db:migrate'
  environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]

  before_migrate do
    directory File.join(release_path, 'vendor')

    node[:algieba][:shared_dirs].each do |dir|
      directory File.join(release_path, "../../shared/#{dir}")
    end

    package 'mysql-devel'

    [['log', 'log'], ['vendor/bundle', 'bundle']].each do |from, to|
      link File.join(release_path, from) do
        to File.join(release_path, "../../shared/#{to}")
        link_type :symbolic
      end
    end

    execute 'rvm 2.2.0 do bundle install --path=vendor/bundle' do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end

    execute 'rvm 2.2.0 do bundle exec rake i18n:js:export' do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end

    node[:algieba][:mysql_users].each do |user|
      execute "mysql -u root -p#{node[:mysql][:root_password]} -e 'GRANT ALL PRIVILEGES ON *.* TO '#{user}'@'localhost';'"
    end

    execute 'rvm 2.2.0 do bundle exec rake db:create' do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]
    end
  end

  before_restart do
    execute 'rvm 2.2.0 do bundle exec rake db:seed' do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]
      only_if { node.chef_environment == 'development' }
    end

    execute 'rvm 2.2.0 do bundle exec rake assets:precompile' do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path], 'RAILS_RELATIVE_URL_ROOT' => "/#{node[:algieba][:app_name]}"
      only_if { node.chef_environment == 'production' }
    end

    execute 'sed -i -e "s/<%= ENV\[\"SECRET_KEY_BASE\"\] %>/`rvm 2.2.0 do bundle exec rake secret`/g" config/secrets.yml' do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]
      only_if { node.chef_environment == 'production' }
    end
  end

  restart_command do
    execute 'rvm 2.2.0 do bundle exec rake unicorn:stop' do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]
      only_if "pgrep -lf 'unicorn_rails.*#{node[:algieba][:app_name]}*'"
    end

    execute 'rvm 2.2.0 do bundle exec rake unicorn:start' do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]
    end
  end
end

if node.chef_environment == 'development'
  execute 'yum -y groupupdate "X Window System"' do
    not_if 'rpm -q xorg-x11-server-Xvfb'
  end

  package %w[ xorg-x11-server-Xvfb firefox ]

  execute 'dbus-uuidgen > /var/lib/dbus/machine-id'
end

node[:algieba][:open_ports].each do |port|
  execute "lokkit -p #{port}"
end
