#
# Cookbook Name:: rvm
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package 'sudo'

node[:rvm][:install_commands].each do |command|
  execute command do
    not_if { File.exist?(node[:rvm][:install_dir]) }
  end
end
