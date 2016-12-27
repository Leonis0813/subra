#
# Cookbook Name:: mysql
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package %w[ mysql mysql-server ] do
  action :install
end

execute "mysqladmin -u root password #{node[:mysql][:root_password]}"

service 'mysqld' do
  action [:enable, :start]
end
