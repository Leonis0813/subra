#
# Cookbook Name:: regulus
# Recipe:: samba
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package node[:regulus][:smb][:packages] do
  action :install
end

template node[:regulus][:smb][:credential_file] do
  user node[:regulus][:username]
  group node[:regulus][:username]
  mode 0600
end

directory node[:regulus][:smb][:mount_dir] do
  user node[:regulus][:username]
  group node[:regulus][:username]
  mode 0755
  not_if { File.exists?(node[:regulus][:smb][:mount_dir]) }
end

win_server = Chef::EncryptedDataBagItem.load('regulus', 'samba')['ip_address']

mount node[:regulus][:smb][:mount_dir] do
  fstype 'cifs'
  device "//#{win_server}/#{node[:regulus][:smb][:share_name]}"
  options "credentials=#{node[:regulus][:smb][:credential_file]}"
  action [:mount, :enable]
end
