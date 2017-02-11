#
# Cookbook Name:: algieba
# Recipe:: ruby
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
[
  "rvm install #{node[:algieba][:ruby_version]}",
  "rvm #{node[:algieba][:ruby_version]}@global do gem install bundler",
].each do |command|
  execute command do
    environment 'PATH' => node[:rvm][:path]
  end
end
