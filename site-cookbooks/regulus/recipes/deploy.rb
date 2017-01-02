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
  branch node[:regulus][:branch]
  action :deploy
  migrate false
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks.clear
end
