#
# Cookbook Name:: alterf
# Recipe:: mount
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
directory node[:alterf][:mount_path] do
  user 'root'
  group 'root'
  mode 0755
  not_if { File.exists?(node[:alterf][:mount_path]) }
end

mount node[:alterf][:mount_path] do
  fstype 'nfs'
  device "160.16.66.112:#{node[:alterf][:deploy_dir]}/shared/backup"
  action [:mount, :enable]
end
