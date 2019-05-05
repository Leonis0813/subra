#
# Cookbook Name:: user
# Recipe:: emacs
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
file "#{node[:user][:home]}/.emacs.el" do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../../emacs/files/default/emacs.el'))
  owner node[:user][:name]
  group node[:user][:name]
  mode '0644'
  action :create
end
