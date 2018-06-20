#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package %w[ mysql mysql-server ] do
  action :install
end

service 'mysqld' do
  action [:enable, :start]
end

execute "mysqladmin -u root password #{node[:mysql][:root_password]}" do
  only_if "mysql -u root -e 'show databases'"
end

file '/etc/my.cnf' do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/my.cnf'))
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

service 'mysqld' do
  action :restart
end
