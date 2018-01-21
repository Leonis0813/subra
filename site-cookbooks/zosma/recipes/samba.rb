#
# Cookbook Name:: zosma
# Recipe:: samba
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package node[:zosma][:smb][:packages] do
  action :install
end

template node[:zosma][:smb][:credential_file] do
  user node[:zosma][:username]
  group node[:zosma][:username]
  mode 0600
end

directory node[:zosma][:smb][:mount_dir] do
  user node[:zosma][:username]
  group node[:zosma][:username]
  mode 0755
  not_if { File.exists?(node[:zosma][:smb][:mount_dir]) }
end

win_server = Chef::EncryptedDataBagItem.load('zosma', 'samba')['ip_address']

mount node[:zosma][:smb][:mount_dir] do
  fstype 'cifs'
  device "//#{win_server}/#{node[:zosma][:smb][:share_name]}"
  options "credentials=#{node[:zosma][:smb][:credential_file]}"
  action [:mount, :enable]
end
