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
  gem_version '2.1.4'
  force true
end

pyenv_python node[:regulus][:python][:version]

pyenv_virtualenv node[:regulus][:app_name] do
  version node[:regulus][:python][:version]
end

%w[pip==19.2.3 setuptools].each do |package|
  pyenv_package package do
    version node[:regulus][:python][:version]
    virtualenv node[:regulus][:app_name]
    option '--upgrade'
  end
end

node[:regulus][:python][:packages].each do |package|
  pyenv_package package do
    version node[:regulus][:python][:version]
    virtualenv node[:regulus][:app_name]
  end
end

tensorflow = node[:regulus][:tensorflow]
pyenv_package "#{tensorflow[:base_url]}/#{tensorflow[:filename]}" do
  version node[:regulus][:python][:version]
  virtualenv node[:regulus][:app_name]
end

package node[:regulus][:requirements]

package 'cronie-anacron' do
  action :remove
end

include_recipe 'regulus::app'

nginx_conf 'regulus'

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
  source "#{geckodriver[:base_url]}/#{geckodriver[:filename]}"
  not_if { File.exist?(geckodriver[:download_path]) }
  only_if { node.chef_environment == 'development' }
end

execute "tar zxvf #{geckodriver[:download_path]}" do
  cwd '/usr/local/bin'
  not_if { File.exist?('/usr/local/bin/geckodriver') }
  only_if { node.chef_environment == 'development' }
end

execute 'dbus-uuidgen > /var/lib/dbus/machine-id' do
  only_if { node.chef_environment == 'development' }
end
