#
# Cookbook Name:: nfs
# Recipe:: export
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

node[:nfs][:exports].each do |app_name, exports|
  template "/etc/exports.d/#{app_name}" do
    source 'exports.erb'
    owner 'root'
    group 'root'
    mode 0644
    variables(:exports => exports)
  end
end

execute 'exportfs -a'
