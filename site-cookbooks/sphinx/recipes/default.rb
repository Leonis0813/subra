#
# Cookbook Name:: sphinx
# Recipe:: install
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#

pyenv = node[:sphinx][:pyenv]
python = node[:sphinx][:python]

git pyenv[:root] do
  repository pyenv[:repository]
  revision pyenv[:revision]
end

execute "install python #{python[:version]}" do
  command <<"EOF"
pyenv init -
pyenv install #{python[:version]}
pyenv global #{python[:version]}
pyenv rehash
EOF
  environment 'PYENV_ROOT' => pyenv[:root],
              'PATH' => '$PYENV_ROOT/bin:$PATH'
end

package node[:sphinx][:requirements] do
  action :install
end

node[:sphinx][:packages].each do |package|
  execute "pip install #{package}"
end
