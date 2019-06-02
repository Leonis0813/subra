#
# Cookbook Name:: alterf
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
ruby_version = node[:alterf][:ruby_version]

rvm_ruby ruby_version

rvm_gem 'bundler' do
  ruby_version ruby_version
  gemset 'global'
end

package node[:alterf][:requirements]

include_recipe 'alterf::app'

execute 'yum -y groupupdate "X Window System"' do
  not_if 'rpm -q xorg-x11-server-Xvfb'
  only_if { node.chef_environment == 'development' }
end

package %w[xorg-x11-server-Xvfb] do
  only_if { node.chef_environment == 'development' }
end

execute 'yum -y install firefox-52.8.0-1.el6.centos.x86_64'

execute 'dbus-uuidgen > /var/lib/dbus/machine-id' do
  only_if { node.chef_environment == 'development' }
end

node[:alterf][:open_ports].each do |port|
  execute "lokkit -p #{port}"
end

install_packages 'install r packages' do
  package DBI: '0.8', RMySQL: '0.10', randomForest: '4.6-12', yaml: '2.1.18'
end
