#
# Cookbook Name:: denebola
# Recipe:: nfs
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
directory node[:denebola][:export_dir] do
  user 'root'
  group 'root'
  mode 0755
  not_if { File.exists?(node[:denebola][:export_dir]) }
end

template File.join(node[:denebola][:export_dir], node[:denebola][:app_name]) do
  cookbook 'nfs'
  source 'exports.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(:exports => node[:denebola][:exports])
end

execute 'exportfs -a'
