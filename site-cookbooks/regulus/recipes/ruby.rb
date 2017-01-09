#
# Cookbook Name:: regulus
# Recipe:: ruby
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
['rvm install 2.2.0', 'rvm 2.2.0 do gem install bundler'].each do |command|
  execute command do
    environment 'PATH' => '/usr/local/rvm/bin:/usr/bin:/bin'
  end
end
