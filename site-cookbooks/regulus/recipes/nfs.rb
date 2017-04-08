#
# Cookbook Name:: regulus
# Recipe:: nfs
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
directory node[:alterf][:export_dir] do
  user 'root'
  group 'root'
  mode 0755
  not_if { File.exists?(node[:alterf][:export_dir]) }
end

template "#{node[:regulus][:export_dir]}/#{node[:regulus][:app_name]}" do
  cookbook 'nfs'
  source 'exports.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(:exports => node[:regulus][:exports])
end

execute 'exportfs -a'
