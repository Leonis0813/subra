#
# Cookbook Name:: regulus
# Recipe:: user
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
user node[:regulus][:username] do
  manage_home false
  shell '/sbin/nologin'
  system true
  action :create
end
