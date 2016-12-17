#
# Cookbook Name:: rvm
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
execute 'install rvm' do
  command <<-"EOF"
curl -sSL #{node[:gpg][:server]} | gpg2 --import -
curl -sSL #{node[:rvm][:server]} | sudo bash -s stable
rvm reload
  EOF
  not_if { File.exists?('/usr/local/rvm') }
end
