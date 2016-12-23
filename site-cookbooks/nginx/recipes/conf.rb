#
# Cookbook Name:: nginx
# Recipe:: conf
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
file '/opt/nginx/conf/nginx.conf' do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/nginx.conf'))
  owner node[:nginx][:user]
  group node[:nginx][:user]
  mode 0644
  action :create
end
