#
# Cookbook Name:: emacs
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
unless emacs_installed?
  package node[:emacs][:requirements] do
    action :install
  end

  remote_file "/tmp/emacs-#{node[:emacs][:version]}.tar.gz" do
    source "http://ftp.gnu.org/pub/gnu/emacs/emacs-#{node[:emacs][:version]}.tar.gz"
    not_if { File.exists?("/tmp/emacs-#{node[:emacs][:version]}.tar.gz") }
  end

  execute "tar zxf emacs-#{node[:emacs][:version]}.tar.gz" do
    cwd '/tmp'
    not_if { File.exists?("/tmp/emacs-#{node[:emacs][:version]}") }
  end

  [
    {:name => 'emacs configuration', :command => './configure --without-x'},
    {:name => 'make emacs', :command => 'make'},
    {:name => 'install emacs', :command => 'sudo make install'},
  ].each do |resource|
    execute resource[:name] do
      command resource[:command]
      cwd "/tmp/emacs-#{node[:emacs][:version]}"
      only_if { File.exists?("/tmp/emacs-#{node[:emacs][:version]}") }
    end
  end
end
