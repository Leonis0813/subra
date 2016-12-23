#
# Cookbook Name:: nginx
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package %w[ pcre pcre-devel ] do
  action :install
end

remote_file "/tmp/nginx-#{node[:nginx][:version]}.tar.gz" do
  source "https://nginx.org/download/nginx-#{node[:nginx][:version]}.tar.gz"
end

execute "tar zxf nginx-#{node[:nginx][:version]}.tar.gz" do
  cwd '/tmp'
end

["./configure --prefix=#{node[:nginx][:install_dir]}", 'make', 'sudo make install'].each do |command|
  execute command do
    cwd "/tmp/nginx-#{node[:nginx][:version]}"
  end
end

file "/tmp/nginx-#{node[:nginx][:version]}.tar.gz" do
  action :delete
end

directory "/tmp/nginx-#{node[:nginx][:version]}" do
  recursive true
  action :delete
end
