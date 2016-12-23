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
  not_if { File.exists?("/tmp/emacs-#{node[:emacs][:version]}.tar.gz") }
end

execute "tar zxf emacs-#{node[:emacs][:version]}.tar.gz" do
  cwd '/tmp'
  not_if { File.exists?("/tmp/emacs-#{node[:emacs][:version]}") }
end

['./configure --without-x', 'make', 'sudo make install'].each do |command|
  execute command do
    cwd "/tmp/emacs-#{node[:emacs][:version]}"
    only_if { File.exists?("/tmp/emacs-#{node[:emacs][:version]}") }
  end
end
