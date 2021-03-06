#
# Cookbook Name:: user
# Recipe:: create
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
user node[:user][:name] do
  home node[:user][:home]
  manage_home true
  password node[:user][:password]
  shell '/bin/zsh'
  action :create
end

group 'rvm' do
  append true
  members [node[:user][:name]]
  action :modify
end

create_sudoer node[:user][:name]
