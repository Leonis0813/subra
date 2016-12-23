#
# Cookbook Name:: rvm
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
unless File.exists?(node[:rvm][:install_dir])
  execute "curl -sSL #{node[:gpg][:server]} | gpg --import -"
  execute "curl -sSL #{node[:rvm][:server]} | sudo bash -s stable"
  execute "#{node[:rvm][:install_dir]}/bin/rvm reload"
end
