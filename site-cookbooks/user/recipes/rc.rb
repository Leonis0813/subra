#
# Cookbook Name:: user
# Recipe:: rc
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
file "#{node[:user][:home]}/.zshrc" do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../../zsh/files/default/zshrc'))
  owner node[:user][:name]
  group node[:user][:name]
  mode 0644
  action :create
end

template "#{node[:user][:home]}/.netrc" do
  source 'netrc.erb'
  owner node[:user][:name]
  group node[:user][:name]
  mode 0644
  action :create
end
