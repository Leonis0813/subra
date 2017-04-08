#
# Cookbook Name:: alterf
# Recipe:: rc.local
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
file '/etc/rc.d/rc.local' do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/rc.local'))
  owner 'root'
  group 'root'
  mode 0755
end

directory '/etc/rc.d/rc.local.d' do
  user 'root'
  group 'root'
  mode 0755
end

template "/etc/rc.d/rc.local.d/#{node[:alterf][:app_name]}" do
  source 'rc.local.erb'
  owner 'root'
  group 'root'
  mode 0755
end
