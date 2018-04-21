#
# Cookbook Name:: nginx
# Recipe:: lua
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
directory "#{node[:nginx][:install_dir]}/conf/lua" do
  owner 'root'
  group 'root'
  mode '0755'
end

node[:nginx][:lua_files].each do |lua_file|
  template "#{node[:nginx][:install_dir]}/conf/lua/#{lua_file}.lua" do
    owner 'nginx'
    group 'nginx'
    mode 0644
  end
end

service 'nginx' do
  action :restart
end
