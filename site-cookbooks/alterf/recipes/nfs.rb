#
# Cookbook Name:: alterf
# Recipe:: nfs
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
template "/etc/exports.d/#{node[:alterf][:app_name]}" do
  cookbook 'nfs'
  source 'exports.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(:exports => node[:alterf][:exports])
end
