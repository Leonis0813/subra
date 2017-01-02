#
# Cookbook Name:: regulus
# Recipe:: rc.local
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
file '/etc/rc.d/rc.local' do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/rc.local'))
  owner 'root'
  group 'root'
  mode 0755
  action :create
end
