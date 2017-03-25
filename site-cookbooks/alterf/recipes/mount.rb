#
# Cookbook Name:: alterf
# Recipe:: mount
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
directory '/mnt/sakura' do
  user 'root'
  group 'root'
  mode 0755
  not_if { File.exists?('/mnt/sakura') }
end

mount '/mnt/sakura' do
  fstype 'nfs'
  device '160.16.66.112:/opt/alterf/shared/backup'
  action [:mount, :enable]
end
