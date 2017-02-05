#
# Cookbook Name:: alterf
# Recipe:: mysql
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
execute 'rvm 2.2.0 do bundle exec ruby mysql/initialize.rb' do
  cwd "#{node[:alterf][:deploy_dir]}/current"
  environment 'PATH' => node[:rvm][:path]
end
