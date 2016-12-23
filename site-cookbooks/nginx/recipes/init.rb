#
# Cookbook Name:: nginx
# Recipe:: init
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
file '/etc/init.d/nginx' do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/nginx'))
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

service 'nginx' do
  action :start
end
