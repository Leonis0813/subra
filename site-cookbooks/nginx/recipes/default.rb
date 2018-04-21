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

  download_luajit_path = File.join(node[:nginx][:luajit][:download][:dir], node[:nginx][:luajit][:src])
  extracted_luajit_dir = download_luajit_path.sub('.tar.gz', '')
  remote_file download_luajit_path do
    source node[:nginx][:luajit][:download][:url]
    not_if { File.exists?(download_luajit_path) }
  end

  execute "tar zxf #{node[:nginx][:luajit][:src]}" do
    cwd node[:nginx][:luajit][:download][:dir]
    not_if { File.exists?(extracted_luajit_dir) }
  end

  [
    {:name => 'make LuaJIT', :command => "make PREFIX=#{node[:nginx][:luajit][:install_dir]}"},
    {:name => 'install LuaJIT', :command => "sudo make install PREFIX=#{node[:nginx][:luajit][:install_dir]}"},
  ].each do |resource|
    execute resource[:name] do
      command resource[:command]
      cwd extracted_luajit_dir
      only_if { File.exists?(extracted_luajit_dir) }
    end
  end

  link '/usr/local/bin/luajit' do
    to '/usr/local/luajit/bin/luajit'
    link_type :symbolic
  end

  download_nginx_devel_kit_path = File.join(node[:nginx][:nginx_devel_kit][:download][:dir], node[:nginx][:nginx_devel_kit][:src])
  remote_file download_nginx_devel_kit_path do
    source node[:nginx][:nginx_devel_kit][:download][:url]
    not_if { File.exists?(download_nginx_devel_kit_path) }
  end

  execute "tar zxf #{node[:nginx][:nginx_devel_kit][:src]}" do
    cwd node[:nginx][:nginx_devel_kit][:download][:dir]
    not_if { File.exists?(download_nginx_devel_kit_path.sub('.tar.gz', '')) }
  end

  download_lua_nginx_module_path = File.join(node[:nginx][:lua_nginx_module][:download][:dir], node[:nginx][:lua_nginx_module][:src])
  remote_file download_lua_nginx_module_path do
    source node[:nginx][:lua_nginx_module][:download][:url]
    not_if { File.exists?(download_lua_nginx_module_path) }
  end

  execute "tar zxf #{node[:nginx][:lua_nginx_module][:src]}" do
    cwd node[:nginx][:lua_nginx_module][:download][:dir]
    not_if { File.exists?(download_lua_nginx_module_path.sub('.tar.gz', '')) }
  end

  download_lua_resty_mysql_path = File.join(node[:nginx][:lua_resty_mysql][:download][:dir], node[:nginx][:lua_resty_mysql][:src])
  remote_file download_lua_resty_mysql_path do
    source node[:nginx][:lua_resty_mysql][:download][:url]
    not_if { File.exists?(download_lua_resty_mysql_path) }
  end

  execute "tar zxf #{node[:nginx][:lua_resty_mysql][:src]}" do
    cwd node[:nginx][:lua_resty_mysql][:download][:dir]
    not_if { File.exists?(download_lua_resty_mysql_path.sub('.tar.gz', '')) }
  end

  options = [
    ['prefix', node[:nginx][:install_dir]],
    ['add-module', "#{node[:nginx][:nginx_devel_kit][:download][:dir]}/ngx_devel_kit-#{node[:nginx][:nginx_devel_kit][:version]}"],
    ['add-module', "#{node[:nginx][:lua_nginx_module][:download][:dir]}/lua-nginx-module-#{node[:nginx][:lua_nginx_module][:version]}"],
    ['with-ld-opt', '"-Wl,-rpath,$LUAJIT_LIB"'],
  ].map {|key, value| "--#{key}=#{value}" }

  execute 'nginx configuration' do
    command "./configure #{options.join(' ')}"
    cwd extracted_dir
    environment 'LUAJIT_LIB' => '/usr/local/luajit/lib', 'LUAJIT_INC' => '/usr/local/luajit/include/luajit-2.0'
  end

  [
    {:name => 'make nginx', :command => 'make'},
    {:name => 'install nginx', :command => 'sudo make install'},
  ].each do |resource|
    execute resource[:name] do
      command resource[:command]
      cwd extracted_dir
      only_if { File.exists?(extracted_dir) }
    end
  end

  file '/etc/init.d/nginx' do
    content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/nginx'))
    owner 'root'
    group 'root'
    mode 0755
    action :create
  end

  include_recipe 'nginx::conf'
  include_recipe 'nginx::lua'
  include_recipe 'nginx::html'

  service 'nginx' do
    action [:start, :enable]
  end
end
