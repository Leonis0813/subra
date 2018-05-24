#
# Cookbook Name:: mysql
# Recipe:: initial_data
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
execute 'create database' do
  query = 'CREATE DATABASE IF NOT EXISTS account DEFAULT CHARACTER SET utf8;'
  command "mysql -u root -p#{node[:mysql][:root_password]} -e '#{query}'"
end

execute 'create users table' do
  query = <<EOF
CREATE TABLE IF NOT EXISTS users(
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  user_id varchar(255) NOT NULL UNIQUE,
  password varchar(255) NOT NULL
)
EOF
  command "mysql -u root -p#{node[:mysql][:root_password]} account -e '#{query}'"
end

execute 'create clients table' do
  query = <<EOF
CREATE TABLE IF NOT EXISTS clients(
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  application_id varchar(255) NOT NULL UNIQUE,
  application_key varchar(255) NOT NULL
)
EOF
  command "mysql -u root -p#{node[:mysql][:root_password]} account -e '#{query}'"
end

users = Chef::EncryptedDataBagItem.load('mysql', 'initial_data')['user'][node.chef_environment]
users.each do |user|
  execute 'create initial users' do
    query = <<"EOF"
INSERT IGNORE INTO users VALUES (NULL, "#{user['user_id']}", "#{user['password']}")
EOF
    command "mysql -u root -p#{node[:mysql][:root_password]} account -e '#{query}'"
  end
end

clients = Chef::EncryptedDataBagItem.load('mysql', 'initial_data')['client'][node.chef_environment]
clients.each do |client|
  execute 'create initial clients' do
    query = <<EOF
INSERT IGNORE INTO clients VALUES (NULL, "#{client['application_id']}", "#{client['application_key']}")
EOF
    command "mysql -u root -p#{node[:mysql][:root_password]} account -e '#{query}'"
  end
end
