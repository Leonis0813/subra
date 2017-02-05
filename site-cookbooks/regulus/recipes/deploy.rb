#
# Cookbook Name:: regulus
# Recipe:: deploy
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
%w[ epel-release R ].each do |name|
  package name do
    action :install
  end
end

deploy node[:regulus][:deploy_dir] do
  repo node[:regulus][:repository]
  branch ENV['REGULUS_VERSION'] || node[:regulus][:branch]
  action :deploy
  migrate false
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks node[:regulus][:symlinks]

  before_migrate do
    directory File.join(release_path, 'vendor')

    node[:regulus][:shared_dirs].each do |dir|
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
      environment 'PATH' => node[:rvm][:path]
    end
  end
end
