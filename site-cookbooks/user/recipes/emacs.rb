#
# Cookbook Name:: user
# Recipe:: emacs
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
config_file = File.absolute_path(
  File.dirname(__FILE__) + '/../../emacs/files/default/emacs.el',
)
file "#{node[:user][:home]}/.emacs.el" do
  content IO.read(config_file)
  owner node[:user][:name]
  group node[:user][:name]
  mode '0644'
  action :create
end
