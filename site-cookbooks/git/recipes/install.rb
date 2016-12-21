#
# Cookbook Name:: git
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package node[:git][:requirements] do
  action :install
end

remote_file "/tmp/git-#{node[:git][:version]}.tar.gz" do
  source "https://www.kernel.org/pub/software/scm/git/git-#{node[:git][:version]}.tar.gz"
end

execute "tar zxf git-#{node[:git][:version]}.tar.gz" do
  cwd '/tmp'
end

execute 'install git' do
  command <<-EOF
make prefix=/usr/local all
make prefix=/usr/local install
  EOF
  cwd "/tmp/git-#{node[:git][:version]}"
end

file "/tmp/git-#{node[:git][:version]}.tar.gz" do
  action :delete
end

directory "/tmp/git-#{node[:git][:version]}" do
  recursive true
  action :delete
end
