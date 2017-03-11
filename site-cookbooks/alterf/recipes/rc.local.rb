#
# Cookbook Name:: alterf
# Recipe:: rc.local
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
template '/etc/rc.d/rc.local' do
  source 'rc.local.erb'
  owner 'root'
  group 'root'
  mode 0775
end
