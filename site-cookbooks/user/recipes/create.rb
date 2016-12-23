#
# Cookbook Name:: user
# Recipe:: create
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
user node[:user][:name] do
  group 'rvm'
  home node[:user][:home]
  manage_home true
  password node[:user][:password]
  shell '/bin/zsh'
  action :create
end
