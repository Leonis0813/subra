#
# Cookbook Name:: docker
# Recipe:: default
#
# Copyright 2018, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package 'docker'

service 'docker' do
  action %i[enable start]
end

config_file = File.absolute_path(File.dirname(__FILE__) + '/../files/default/docker-storage')
file '/etc/sysconfig/docker-storage' do
  content IO.read(config_file)
  owner 'root'
  group 'root'
  mode '0644'
end
