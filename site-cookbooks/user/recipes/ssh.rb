#
# Cookbook Name:: user
# Recipe:: ssh
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
directory "#{node[:user][:home]}/.ssh" do
  owner node[:user][:name]
  group node[:user][:name]
  mode '0700'
  action :create
end

file "#{node[:user][:home]}/.ssh/authorized_keys" do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + "/../files/default/#{node[:user][:name]}/id_rsa.pub"))
  owner node[:user][:name]
  group node[:user][:name]
  mode '0644'
  action :create
end
