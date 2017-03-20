#
# Cookbook Name:: nfs
# Recipe:: install
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package 'nfs-utils'

node[:nfs][:services].each do |service_name|
  service service_name do
    action node[:nfs][:actions]
  end
end
