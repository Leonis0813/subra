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

pub_key_file = File.absolute_path(
  File.dirname(__FILE__) + "/../files/default/#{node[:user][:name]}/id_rsa.pub",
)
file "#{node[:user][:home]}/.ssh/authorized_keys" do
  content IO.read(pub_key_file)
  owner node[:user][:name]
  group node[:user][:name]
  mode '0644'
  action :create
end
