#
# Cookbook Name:: regulus
# Recipe:: default
#
# Copyright 2018, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
ruby_version = node[:regulus][:ruby_version]

rvm_ruby ruby_version

rvm_gem 'bundler' do
  ruby_version ruby_version
  gemset 'global'
end

include_recipe 'regulus::app'

node[:regulus][:open_ports].each do |port|
  execute "lokkit -p #{port}"
end

pyenv = node[:tensorflow][:pyenv]
python = node[:tensorflow][:python]

node[:regulus][:python_packages].each do |package|
  execute "pyenv global #{python[:version]} && pip install #{package}" do
    environment 'PYENV_ROOT' => pyenv[:root],
                'PATH' => "#{pyenv[:root]}/versions/#{python[:version]}/bin:#{pyenv[:root]}/bin:/usr/bin:/bin"
  end
end

execute 'yum -y groupupdate "X Window System"' do
  not_if 'rpm -q xorg-x11-server-Xvfb'
  only_if { node.chef_environment == 'development' }
end

package %w[ xorg-x11-server-Xvfb ] do
  only_if { node.chef_environment == 'development' }
end

execute 'yum -y install firefox-52.8.0-1.el6.centos.x86_64' do
  only_if { node.chef_environment == 'development' }
end

execute 'dbus-uuidgen > /var/lib/dbus/machine-id' do
  only_if { node.chef_environment == 'development' }
end
