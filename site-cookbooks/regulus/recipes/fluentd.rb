#
# Cookbook Name:: regulus
# Recipe:: fluentd
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
execute 'curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh' do
  not_if { File.exists?('/etc/td-agent') }
end
