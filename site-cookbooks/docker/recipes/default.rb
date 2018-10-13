#
# Cookbook Name:: docker
# Recipe:: default
#
# Copyright 2018, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package 'docker-io'

service 'docker' do
  action [:enable, :start]
end
