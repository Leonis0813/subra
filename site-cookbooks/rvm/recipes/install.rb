#
# Cookbook Name:: rvm
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
unless File.exists?(node[:rvm][:install_dir])
  node[:rvm][:install_commands].each do |command|
    execute command
  end
end
