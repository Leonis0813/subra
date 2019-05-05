#
# Cookbook Name:: mysql
# Recipe:: initial_data
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
mysql_query 'create database' do
  query 'create_database.sql'
end

mysql_query 'create users table' do
  query 'create_table_users.sql'
  table 'account'
end

mysql_query 'create clients table' do
  query 'create_table_clients.sql'
  table 'account'
end

initial_data = Chef::EncryptedDataBagItem.load('mysql', 'initial_data')

(initial_data['user'][node.chef_environment] || []).each do |user|
  mysql_query 'create initial users' do
    query "INSERT IGNORE INTO users VALUES (NULL, \"#{user['user_id']}\", " \
          "\"#{user['password']}\")"
    query_type 'string'
    table 'account'
  end
end

(initial_data['client'][node.chef_environment] || []).each do |client|
  mysql_query 'create initial clients' do
    query "INSERT IGNORE INTO clients VALUES (NULL, \"#{client['application_id']}\", " \
          "\"#{client['application_key']}\")"
    query_type 'string'
    table 'account'
  end
end
