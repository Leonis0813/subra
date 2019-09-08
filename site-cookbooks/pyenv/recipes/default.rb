#
# Cookbook Name:: pyenv
# Recipe:: default
#
# Copyright 2019, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
pyenv = node[:pyenv]
virtualenv = node[:pyenv][:virtualenv]

package node[:pyenv][:requirements]

git pyenv[:root] do
  repository pyenv[:repository]
  revision pyenv[:revision]
  not_if { File.exist?(pyenv[:root]) }
end

git virtualenv[:root] do
  repository virtualenv[:repository]
  revision virtualenv[:revision]
  not_if { File.exist?(virtualenv[:root]) }
end
