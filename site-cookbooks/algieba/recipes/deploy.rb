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
  environment 'RAILS_ENV' => node[:algieba][:environment],
              'PATH' => '/usr/local/rvm/bin:/usr/bin:/bin'

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
      environment 'PATH' => '/usr/local/rvm/bin:/usr/bin:/bin'
    end

    execute 'add privileges' do
      command "mysql -u root -p7QiSlC?4 -e 'GRANT ALL PRIVILEGES ON *.* TO '#{node[:algieba][:environment]}'@'localhost';'"
    end

    execute 'rvm 2.2.0 do bundle exec rake db:create' do
      cwd release_path
      environment 'PATH' => '/usr/local/rvm/bin:/usr/bin:/bin',
                  'RAILS_ENV' => node[:algieba][:environment]
    end
  end

  before_restart do
    execute 'rvm 2.2.0 do bundle exec rake db:seed' do
      cwd release_path
      environment 'RAILS_ENV' => node[:algieba][:environment],
                  'PATH' => '/usr/local/rvm/bin:/usr/bin:/bin'
    end

    execute 'rvm 2.2.0 do bundle exec rake assets:precompile' do
      cwd release_path
      environment 'RAILS_ENV' => node[:algieba][:environment],
                  'PATH' => '/usr/local/rvm/bin:/usr/bin:/bin'
      only_if { node[:algieba][:environment] == 'production' }
    end
  end

  restart_command 'rvm 2.2.0 do bundle exec rake unicorn:restart'
end
