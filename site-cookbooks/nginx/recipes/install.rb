#
# Cookbook Name:: nginx
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
unless File.exists?(node[:nginx][:install_dir])
  package node[:nginx][:requirements] do
    action :install
  end

  remote_file "/tmp/nginx-#{node[:nginx][:version]}.tar.gz" do
    source "https://nginx.org/download/nginx-#{node[:nginx][:version]}.tar.gz"
    not_if { File.exists?("/tmp/nginx-#{node[:nginx][:version]}.tar.gz") }
  end

  execute "tar zxf nginx-#{node[:nginx][:version]}.tar.gz" do
    cwd '/tmp'
    not_if { File.exists?("/tmp/nginx-#{node[:nginx][:version]}") }
  end

  ["./configure --prefix=#{node[:nginx][:install_dir]}", 'make', 'sudo make install'].each do |command|
    execute command do
      cwd "/tmp/nginx-#{node[:nginx][:version]}"
      only_if { File.exists?("/tmp/nginx-#{node[:nginx][:version]}") }
    end
  end

  file "#{node[:nginx][:install_dir]}/conf/nginx.conf" do
    content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/nginx.conf'))
    owner node[:nginx][:user]
    group node[:nginx][:user]
    mode 0644
    action :create
  end

  file '/etc/init.d/nginx' do
    content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/nginx'))
    owner 'root'
    group 'root'
    mode 0755
    action :create
  end

  service 'nginx' do
    action :start
  end
end
