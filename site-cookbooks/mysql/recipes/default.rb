#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
remote_file node[:mysql][:repository][:file_path] do
  source node[:mysql][:repository][:url]
  owner 'root'
  group 'root'
  mode '0755'
  not_if { File.exist?(node[:mysql][:repository][:file_path]) }
end

package 'mysql-community-release' do
  source node[:mysql][:repository][:file_path]
end

package node[:mysql][:requirements]

execute 'yum-config-manager --disable mysql57-community'
execute 'yum-config-manager --enable mysql56-community'

package 'mysql-community-server'

execute 'systemctl enable mysqld'
execute 'systemctl start mysqld'

execute "mysqladmin -u root password #{node[:mysql][:root_password]}" do
  only_if "mysql -u root -e 'show databases'"
end

config_file = File.absolute_path(File.dirname(__FILE__) + '/../files/default/my.cnf')
file '/etc/my.cnf' do
  content IO.read(config_file)
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'systemctl restart mysqld'
