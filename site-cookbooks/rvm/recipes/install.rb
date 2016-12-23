#
# Cookbook Name:: rvm
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
unless File.exists?(node[:rvm][:install_dir])
  [
    "curl -sSL #{node[:gpg][:server]} | gpg --import -",
    "curl -sSL #{node[:rvm][:server]} | sudo bash -s stable",
    "#{node[:rvm][:install_dir]}/bin/rvm reload",
  ].each do |command|
    execute command
  end
end
