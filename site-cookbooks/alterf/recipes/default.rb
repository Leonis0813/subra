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
  gem_version '1.17.3'
end

pyenv_python node[:alterf][:python][:version]
pyenv_virtualenv node[:alterf][:app_name] do
  version node[:alterf][:python][:version]
end

%w[pip==19.2.3 setuptools].each do |package|
  pyenv_package package do
    version node[:alterf][:python][:version]
    virtualenv node[:alterf][:app_name]
    option '--upgrade'
  end
end

node[:alterf][:python][:packages].each do |package|
  pyenv_package package do
    version node[:alterf][:python][:version]
    virtualenv node[:alterf][:app_name]
  end
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

execute 'yum -y install firefox-60.8.0-1.el7.centos.x86_64' do
  only_if { node.chef_environment == 'development' }
end

geckodriver = node[:algieba][:geckodriver]
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
