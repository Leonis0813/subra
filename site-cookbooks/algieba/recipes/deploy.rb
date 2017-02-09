#
# Cookbook Name:: algieba
# Recipe:: deploy
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

    package 'mysql-devel' do
      action :install
    end

    link File.join(release_path, 'vendor/bundle') do
      to File.join(release_path, '../../shared/bundle')
      link_type :symbolic
    end

    execute 'rvm 2.2.0 do bundle install --path=vendor/bundle' do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end

    execute "mysql -u root -p#{node[:mysql][:root_password]} -e 'GRANT ALL PRIVILEGES ON *.* TO '#{node.chef_environment}'@'localhost';'"

    execute 'rvm 2.2.0 do bundle exec rake db:create' do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]
    end
  end

  before_restart do
    execute 'rvm 2.2.0 do bundle exec rake db:seed' do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]
    end

    execute 'rvm 2.2.0 do bundle exec rake assets:precompile' do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]
      only_if { node.chef_environment == 'production' }
    end
  end

  if File.exists?("#{node[:algieba][:deploy_dir]}/shared/tmp/pids/unicorn.pid")
    restart_command 'rvm 2.2.0 do bundle exec rake unicorn:restart'
  else
    restart_command "rvm 2.2.0 do bundle exec rake unicorn:start RAILS_ENV=#{node.chef_environment}"
  end
end

if node.chef_environment == 'development'
  execute 'yum -y groupupdate "X Window System"' do
    not_if 'rpm -q xorg-x11-server-Xvfb'
  end

  package 'xorg-x11-server-Xvfb' do
    not_if 'rpm -q xorg-x11-server-Xvfb'
  end

  execute 'dbus-uuidgen > /var/lib/dbus/machine-id'
end
