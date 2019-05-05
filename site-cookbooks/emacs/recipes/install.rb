#
# Cookbook Name:: emacs
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
unless emacs_installed?
  download_path = File.join(node[:emacs][:download][:dir], node[:emacs][:download][:file])
  extracted_dir = download_path.sub('.tar.gz', '')

  package node[:emacs][:requirements] do
    action :install
  end

  remote_file download_path do
    source node[:emacs][:download][:url]
    not_if { File.exists?(download_path) }
  end

  execute "tar zxf #{node[:emacs][:download][:file]}" do
    cwd node[:emacs][:download][:dir]
    not_if { File.exists?(extracted_dir) }
  end

  [
    {name: 'emacs configuration', command: './configure --without-x'},
    {name: 'make emacs', command: 'make'},
    {name: 'install emacs', command: 'sudo make install'},
  ].each do |resource|
    execute resource[:name] do
      command resource[:command]
      cwd extracted_dir
      only_if { File.exists?(extracted_dir) }
    end
  end
end
