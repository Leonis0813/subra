#
# Cookbook Name:: git
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
unless git_installed?
  download_path = File.join(node[:git][:download][:dir], node[:git][:download][:file])
  extracted_dir = download_path.sub('.tar.gz', '')

  package node[:git][:requirements] do
    action :install
  end

  remote_file download_path do
    source node[:git][:download][:url]
    not_if { File.exist?(download_path) }
  end

  execute "tar zxf #{node[:git][:download][:file]}" do
    cwd node[:git][:download][:dir]
    not_if { File.exist?(extracted_dir) }
  end

  node[:git][:install_commands].each do |command|
    execute command do
      cwd extracted_dir
      only_if { File.exist?(extracted_dir) }
    end
  end
end
