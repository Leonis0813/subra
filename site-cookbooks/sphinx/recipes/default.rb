#
# Cookbook Name:: sphinx
# Recipe:: default
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
python = node[:sphinx][:python]

pyenv_python python[:version]
pyenv_virtualenv python[:virtualenv] do
  version python[:version]
end

package node[:sphinx][:requirements]

node[:sphinx][:packages].each do |package|
  pyenv_package package do
    version python[:version]
    virtualenv python[:virtualenv]
  end
end
