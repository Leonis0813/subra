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
  not_if { File.exists("/tmp/nginx-#{node[:nginx][:version]}.tar.gz") }
end

execute "tar zxf nginx-#{node[:nginx][:version]}.tar.gz" do
  cwd '/tmp'
  not_if { File.exists("/tmp/nginx-#{node[:nginx][:version]}") }
end

["./configure --prefix=#{node[:nginx][:install_dir]}", 'make', 'sudo make install'].each do |command|
  execute command do
    cwd "/tmp/nginx-#{node[:nginx][:version]}"
    only_if { File.exists("/tmp/nginx-#{node[:nginx][:version]}") }
  end
end