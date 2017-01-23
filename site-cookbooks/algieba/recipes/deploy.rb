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
  branch node[:algieba][:branch]
  action :deploy
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlink_before_migrate.clear
  symlinks node[:algieba][:symlinks]

  before_migrate do
    directory File.join(release_path, 'vendor')

    node[:algieba][:shared_dirs].each do |dir|
      directory File.join(release_path, "../../shared/#{dir}") do
        recursive true
      end
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
  end
end
