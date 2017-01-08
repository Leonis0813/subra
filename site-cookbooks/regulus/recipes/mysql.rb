#
# Cookbook Name:: regulus
# Recipe:: mysql
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
execute 'rvm 2.2.0 do bundle exec ruby mysql/initialize.rb' do
  cwd "#{node[:regulus][:deploy_dir]}/current"
  environment 'PATH' => '/usr/local/rvm/bin:/usr/bin:/bin'
end
