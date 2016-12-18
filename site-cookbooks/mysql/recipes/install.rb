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

service 'mysqld' do
  action [:enable, :start]
end
