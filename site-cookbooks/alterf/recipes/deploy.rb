#
# Cookbook Name:: alterf
# Recipe:: deploy
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
deploy node[:alterf][:deploy_dir] do
  repo node[:alterf][:repository]
  branch node[:alterf][:branch]
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

    package 'mysql-devel' do
      action :install
    end

    link File.join(release_path, 'vendor/bundle') do
      to File.join(release_path, '../../shared/bundle')
      link_type :symbolic
    end

    execute 'bundle install --path=vendor/bundle' do
      cwd release_path
    end
  end
end
