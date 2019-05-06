#
# Cookbook Name:: denebola
# Recipe:: app
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
ruby_version = node[:denebola][:ruby_version]
rvm_do = "rvm #{ruby_version} do"

deploy node[:denebola][:deploy_dir] do
  repo node[:denebola][:repository]
  branch ENV['DENEBOLA_VERSION'] || node[:denebola][:branch]
  migrate true
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlink_before_migrate.clear
  symlinks node[:denebola][:symlinks]
  migration_command "#{rvm_do} bundle exec rake db:migrate"
  environment 'RAILS_ENV' => node.chef_environment.sub('compute', 'production'),
              'PATH' => node[:rvm][:path]

  before_migrate do
    directory File.join(release_path, 'vendor')

    node[:denebola][:shared_dirs].each do |dir|
      directory File.join(node[:denebola][:deploy_dir], "shared/#{dir}") do
        recursive true
      end
    end

    {'log' => 'log', 'vendor/bundle' => 'bundle'}.each do |from, to|
      link File.join(release_path, from) do
        to File.join(node[:denebola][:deploy_dir], "shared/#{to}")
      end
    end

    node[:denebola][:requirements].each do |package_name|
      package package_name
    end

    execute "#{rvm_do} bundle install --path=vendor/bundle --clean" do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end

    execute "#{rvm_do} bundle exec rake db:create" do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end
  end
end
