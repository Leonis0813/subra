#
# Cookbook Name:: regulus
# Recipe:: fluentd
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
execute 'rpm --import https://packages.treasuredata.com/GPG-KEY-td-agent'

file '/etc/yum.repos.d/treasuredata.repo' do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/treasuredata.repo'))
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

package 'td-agent' do
  action :install
end
