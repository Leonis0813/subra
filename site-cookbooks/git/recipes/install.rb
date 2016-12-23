#
# Cookbook Name:: git
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
unless git_installed?
  package node[:git][:requirements] do
    action :install
  end

  remote_file "/tmp/git-#{node[:git][:version]}.tar.gz" do
    source "https://www.kernel.org/pub/software/scm/git/git-#{node[:git][:version]}.tar.gz"
    not_if { File.exists?("/tmp/git-#{node[:git][:version]}.tar.gz") }
  end

  execute "tar zxf git-#{node[:git][:version]}.tar.gz" do
    cwd '/tmp'
    not_if { File.exists?("/tmp/git-#{node[:git][:version]}") }
  end

  ['make prefix=/usr/local all', 'make prefix=/usr/local install'].each do |command|
    execute command do
      cwd "/tmp/git-#{node[:git][:version]}"
      only_if { File.exists?("/tmp/git-#{node[:git][:version]}") }
    end
  end
end
