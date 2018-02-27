#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package 'redis' do
  action :install
end

service 'redis' do
  action [:enable, :start]
end
