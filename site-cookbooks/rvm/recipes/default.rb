#
# Cookbook Name:: rvm
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute 'install rvm' do
  command <<-"EOF"
gpg --keyserver #{node[:gpg][:server]} --recv-keys #{node[:gpg][:key]}
curl -sSL #{node[:rvm][:server] | sudo bash -s stable
rvm reload
  EOF
  not_if rvm_installed?
end
