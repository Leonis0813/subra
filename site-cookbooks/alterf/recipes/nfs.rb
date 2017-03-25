#
# Cookbook Name:: alterf
# Recipe:: nfs
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
directory '/etc/exports.d' do
  user 'root'
  group 'root'
  mode 0755
  not_if { File.exists?('/etc/exports.d') }
end

template "/etc/exports.d/#{node[:alterf][:app_name]}" do
  cookbook 'nfs'
  source 'exports.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(:exports => node[:alterf][:exports])
end

execute 'exportfs -a'
