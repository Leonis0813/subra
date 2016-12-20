#
# Cookbook Name:: user
# Recipe:: create
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
user 'developer' do
  home '/home/developer'
  manage_home true
  password '$1$hvu.l2c/$CBK7AJrXkQGZNFv.wj4bB.'
  action :create
end

directory '/home/developer/.ssh' do
  owner 'developer'
  group 'developer'
  mode 0700
  action :create
end

file '/home/developer/.ssh/authorized_keys' do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/developer/id_rsa.pub'))
  owner 'developer'
  group 'developer'
  mode '0644'
  action :create
end
