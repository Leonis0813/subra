#
# Cookbook Name:: emacs
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package node[:emacs][:requirements] do
  action :install
end

remote_file "/tmp/emacs-#{node[:emacs][:version]}.tar.gz" do
  source "http://ftp.gnu.org/pub/gnu/emacs/emacs-#{node[:emacs][:version]}.tar.gz"
end

execute "tar zxf emacs-#{node[:emacs][:version]}.tar.gz" do
  cwd '/tmp'
end

execute './configure --without-x' do
  cwd "/tmp/emacs-#{node[:emacs][:version]}"
end

execute 'make' do
  cwd "/tmp/emacs-#{node[:emacs][:version]}"
end

execute 'sudo make install' do
  cwd "/tmp/emacs-#{node[:emacs][:version]}"
end

file "/tmp/emacs-#{node[:emacs][:version]}.tar.gz" do
  action :delete
end

directory "/tmp/emacs-#{node[:emacs][:version]}" do
  recursive true
  action :delete
end
