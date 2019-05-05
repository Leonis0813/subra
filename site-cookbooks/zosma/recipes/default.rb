#
# Cookbook Name:: zosma
# Recipe:: default
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
ruby_version = node[:zosma][:ruby_version]

rvm_ruby ruby_version

rvm_gem 'bundler' do
  ruby_version ruby_version
  gemset 'global'
end

include_recipe 'zosma::app'

user node[:zosma][:username] do
  manage_home false
  shell '/sbin/nologin'
  system true
  action :create
end

package node[:zosma][:smb][:packages]

template node[:zosma][:smb][:credential_file] do
  user node[:zosma][:username]
  group node[:zosma][:username]
  mode '0600'
end

directory node[:zosma][:smb][:mount_dir] do
  user node[:zosma][:username]
  group node[:zosma][:username]
  mode '0755'
  not_if { File.exists?(node[:zosma][:smb][:mount_dir]) }
end

win_server = Chef::EncryptedDataBagItem.load('zosma', 'samba')['ip_address']

mount node[:zosma][:smb][:mount_dir] do
  fstype 'cifs'
  device "//#{win_server}/#{node[:zosma][:smb][:share_name]}"
  options "credentials=#{node[:zosma][:smb][:credential_file]}"
  action %i[mount enable]
end
