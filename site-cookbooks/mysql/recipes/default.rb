#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package %w[mysql mysql-server]

service 'mysqld' do
  action %i[enable start]
end

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

service 'mysqld' do
  action :restart
end
