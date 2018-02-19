#
# Cookbook Name:: zosma
# Recipe:: deploy
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
deploy node[:zosma][:deploy_dir] do
  repo node[:zosma][:repository]
  branch ENV['ZOSMA_VERSION'] || node[:zosma][:branch]
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks node[:zosma][:symlinks]

  before_migrate do
    directory File.join(release_path, 'vendor')

    node[:zosma][:shared_dirs].each do |dir|
      directory File.join(node[:zosma][:deploy_dir], "shared/#{dir}") do
        recursive true
      end
    end

    link File.join(release_path, 'vendor/bundle') do
      to File.join(node[:zosma][:deploy_dir], 'shared/bundle')
    end

    execute 'rvm 2.2.0 do bundle install --path=vendor/bundle' do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end

    node[:zosma][:requirements].each do |package_name|
      package package_name
    end
  end

  before_restart do
    execute 'rvm 2.2.0 do bundle exec ruby db/initialize.rb' do
      cwd release_path
      environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]
    end
  end
end
