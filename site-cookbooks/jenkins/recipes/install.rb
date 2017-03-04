#
# Cookbook Name:: jenkins
# Recipe:: install
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
remote_file node[:jenkins][:rpm_path] do
  source node[:jenkins][:rpm_url]
  owner 'root'
  group 'root'
  mode 0755
  not_if { File.exists?(node[:jenkins][:rpm_path]) }
end

package 'java-1.8.0-openjdk' do
  not_if 'rpm -q java'
end

package 'jenkins' do
  source node[:jenkins][:rpm_path]
  not_if 'rpm -q jenkins'
end

create_sudoer 'jenkins'

service 'jenkins' do
  action [:enable, :start]
end

execute 'netstat -ant | grep 8080 | grep LISTEN' do
  retries 5
  retry_delay 10
end

service 'network' do
  action [:restart]
end
