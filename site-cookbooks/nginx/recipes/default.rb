#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
unless File.exists?(node[:nginx][:install_dir])
  download_path = File.join(node[:nginx][:download][:dir], node[:nginx][:download][:file])
  extracted_dir = download_path.sub('.tar.gz', '')

  user node[:nginx][:user] do
    manage_home false
    shell '/sbin/nologin'
    system true
  end

  package node[:nginx][:requirements]

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

  include_recipe 'nginx::conf'

  file '/etc/init.d/nginx' do
    content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/nginx'))
    owner 'root'
    group 'root'
    mode 0755
    action :create
  end

  service 'nginx' do
    action [:start, :enable]
  end
end
