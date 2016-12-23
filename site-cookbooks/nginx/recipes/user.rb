#
# Cookbook Name:: nginx
# Recipe:: user
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
user node[:nginx][:user] do
  manage_home false
  shell '/sbin/nologin'
  action :create
end
