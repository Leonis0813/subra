#
# Cookbook Name:: alterf
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
deploy node[:alterf][:deploy_dir] do
  repo node[:alterf][:repository]
  branch ENV['ALTERF_VERSION'] || node[:alterf][:branch]
  migrate true
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlink_before_migrate.clear
  symlinks node[:alterf][:symlinks]
  migration_command "rvm #{node[:alterf][:ruby_version]} do bundle exec rake db:migrate"
  environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'), 'PATH' => node[:rvm][:path]

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

    node[:alterf][:requirements].each do |package_name|
      package package_name
    end

    execute 'rvm 2.2.0 do bundle install --path=vendor/bundle' do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end

    node[:alterf][:mysql_users].each do |user|
      execute "mysql -u root -p#{node[:mysql][:root_password]} -e 'GRANT ALL PRIVILEGES ON *.* TO '#{user}'@'localhost';'"
    end
  end

  before_restart do
    template File.join(release_path, 'scripts/settings.yml') do
      source 'settings.yml.erb'
      owner 'root'
      group 'root'
      mode 0644
    end

    execute 'rvm 2.2.0 do bundle exec rake resque:worker:restart' do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end

    gmail = Chef::EncryptedDataBagItem.load('alterf', 'gmail')
    template File.join(release_path, 'config/initializers/action_mailer.rb') do
      source 'action_mailer.rb.erb'
      owner 'root'
      group 'root'
      mode 0644
      variables(:user_name => gmail['user_name'], :password => gmail['password'])
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
      environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'), 'PATH' => node[:rvm][:path]
      only_if "pgrep -lf 'unicorn_rails.*#{node[:alterf][:app_name]}*'"
    end

    execute 'rvm 2.2.0 do bundle exec rake unicorn:start' do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'), 'PATH' => node[:rvm][:path]
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

node[:alterf][:open_ports].each do |port|
  execute "lokkit -p #{port}"
end
