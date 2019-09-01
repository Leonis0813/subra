#
# Cookbook Name:: nginx
# Recipe:: conf
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
directory "#{node[:nginx][:install_dir]}/conf.d" do
  owner 'root'
  group 'root'
  mode '0755'
end

node[:nginx][:conf_files].each do |conf_file|
  conf_file_path = File.absolute_path(
    File.dirname(__FILE__) + '/../files/default/conf/' + conf_file,
  )

  file "#{node[:nginx][:install_dir]}/conf.d/#{conf_file}.conf" do
    content IO.read(conf_file_path)
    owner 'root'
    group 'root'
    mode '0755'
  end
end

template "#{node[:nginx][:install_dir]}/conf/nginx.conf" do
  owner 'nginx'
  group 'nginx'
  mode '0644'
  variables(nginx_apps: node[:nginx][:apps])
end

execute '/etc/init.d/nginx restart'
