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

node[:alterf][:mount_settings].each do |setting|
  mount setting[:path] do
    fstype setting[:fstype]
    device setting[:device]
    action [:mount, :enable]
  end
end
