#
# Cookbook Name:: regulus
# Recipe:: samba
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package %w[ samba-client cifs-utils ] do
  action :install
end

template '/etc/smb.cred' do
  user node[:regulus][:username]
  group node[:regulus][:username]
  mode 0600
end

mount '/tmp/smb' do
  fstype 'cifs'
  device '\\\\winServer.com\\dir\\folder\\subfolder'
  options 'credentials=/etc/smb.cred'
  action [:mount, :enable]
end
