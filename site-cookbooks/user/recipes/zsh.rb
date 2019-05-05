#
# Cookbook Name:: user
# Recipe:: zsh
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
rc_file = File.absolute_path(
  File.dirname(__FILE__) + '/../../zsh/files/default/zshrc',
)
file "#{node[:user][:home]}/.zshrc" do
  content IO.read(rc_file)
  owner node[:user][:name]
  group node[:user][:name]
  mode '0644'
  action :create
end
