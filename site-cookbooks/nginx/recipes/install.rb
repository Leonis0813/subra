#
# Cookbook Name:: nginx
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
unless File.exists?(node[:nginx][:install_dir])
  download_path = File.join(node[:nginx][:download][:dir], node[:nginx][:download][:file])
  extracted_dir = download_path.sub('.tar.gz', '')

  package node[:nginx][:requirements] do
    action :install
  end

  remote_file download_path do
    source node[:nginx][:download][:url]
    not_if { File.exists?(download_path) }
  end

  execute "tar zxf #{node[:nginx][:download][:file]}" do
    cwd node[:nginx][:download][:dir]
    not_if { File.exists?(extracted_dir) }
  end

  [
    {:name => 'nginx configuration', :command => "./configure --prefix=#{node[:nginx][:install_dir]}"},
    {:name => 'make nginx', :command => 'make'},
    {:name => 'install nginx', :command => 'sudo make install'},
  ].each do |resource|
    execute resource[:name] do
      command resource[:command]
      cwd extracted_dir
      only_if { File.exists?(extracted_dir) }
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

  execute 'lokkit -p 80:tcp'

  service 'nginx' do
    action :start
  end
end
