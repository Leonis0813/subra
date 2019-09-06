#
# Cookbook Name:: regulus
# Recipe:: default
#
# Copyright 2018, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
ruby_version = node[:regulus][:ruby_version]

rvm_ruby ruby_version

rvm_gem 'bundler' do
  ruby_version ruby_version
  gemset 'global'
  gem_version '1.17.3'
end

execute 'docker pull tensorflow/tensorflow:1.13.1' do
  not_if "docker ps | grep #{node[:regulus][:app_name]}"
end

package node[:regulus][:requirements]

include_recipe 'regulus::app'

execute 'yum -y groupupdate "X Window System"' do
  not_if 'rpm -q xorg-x11-server-Xvfb'
  only_if { node.chef_environment == 'development' }
end

package %w[xorg-x11-server-Xvfb] do
  only_if { node.chef_environment == 'development' }
end

execute 'yum -y install firefox-60.8.0-1.el7.centos.x86_64' do
  only_if { node.chef_environment == 'development' }
end

geckodriver = node[:regulus][:geckodriver]
remote_file geckodriver[:download_path] do
  source "#{geckodriver[:base_url]}/#{geckodriver[:version]}/geckodriver-#{geckodriver[:version]}-linux64.tar.gz"
  not_if { File.exists?(geckodriver[:download_path]) }
  only_if { node.chef_environment == 'development' }
end

execute "tar zxvf #{geckodriver[:download_path]}" do
  cwd '/usr/local/bin'
  not_if { File.exists?('/usr/local/bin/geckodriver') }
  only_if { node.chef_environment == 'development' }
end

execute 'dbus-uuidgen > /var/lib/dbus/machine-id' do
  only_if { node.chef_environment == 'development' }
end
