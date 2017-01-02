#
# Cookbook Name:: regulus
# Recipe:: mysql
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
execute 'CREATE DATABASE IF NOT EXISTS regulus DEFAULT CHARACTER SET utf8'

node[:regulus][:sql_files].each do |sql_file|
  execute "mysql -u #{node[:regulus][:username]} -p#{node[:regulus][:password]} regulus < #{sql_file}"
end
