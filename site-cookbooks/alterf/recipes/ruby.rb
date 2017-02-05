#
# Cookbook Name:: alterf
# Recipe:: ruby
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
[
  "rvm install #{node[:alterf][:ruby_version]}",
  "rvm #{node[:alterf][:ruby_version]}@global do gem install bundler",
].each do |command|
  execute command do
    environment 'PATH' => node[:rvm][:path]
  end
end
