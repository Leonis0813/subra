#
# Cookbook Name:: sphinx
# Recipe:: install
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package node[:sphinx][:requirements] do
  action :install
end

node[:sphinx][:packages].each do |package|
  execute "pip install #{package}"
end
