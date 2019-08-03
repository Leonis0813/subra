#
# Cookbook Name:: denebola
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
ruby_version = node[:denebola][:ruby_version]

rvm_ruby ruby_version

rvm_gem 'bundler' do
  ruby_version ruby_version
  gemset 'global'
  gem_version '1.17.3'
end

package node[:denebola][:requirements]

include_recipe 'denebola::app'
