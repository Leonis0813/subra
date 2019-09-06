#
# Cookbook Name:: docker
# Recipe:: default
#
# Copyright 2018, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package 'docker'

service 'docker' do
  action %i[enable start]
end
