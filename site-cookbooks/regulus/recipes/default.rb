#
# Cookbook Name:: regulus
# Recipe:: default
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
ruby_version = node[:regulus][:ruby_version]

rvm_ruby ruby_version

rvm_gem 'bundler' do
  ruby_version ruby_version
  gemset 'global'
end

include_recipe 'regulus::app'

execute 'yum -y groupupdate "X Window System"' do
  not_if 'rpm -q xorg-x11-server-Xvfb'
  only_if { node.chef_environment == 'development' }
end

package %w[ xorg-x11-server-Xvfb firefox ] do
  only_if { node.chef_environment == 'development' }
end

execute 'dbus-uuidgen > /var/lib/dbus/machine-id' do
  only_if { node.chef_environment == 'development' }
end

node[:regulus][:open_ports].each do |port|
  execute "lokkit -p #{port}"
end
