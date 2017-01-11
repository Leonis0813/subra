#
# Cookbook Name:: jenkins
# Recipe:: install
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
remote_file "/tmp/jenkins-#{node[:jenkins][:version]}-1.1.noarch.rpm" do
  source "http://pkg.jenkins-ci.org/redhat/jenkins-#{node[:jenkins][:version]}-1.1.noarch.rpm"
  owner 'root'
  group 'root'
  mode 0755
  not_if { File.exists?("/tmp/nginx-#{node[:jenkins][:version]}") }
end

package 'jenkins' do
  source "/tmp/jenkins-#{node[:jenkins][:version]}-1.1.noarch.rpm"
  not_if 'rpm -q jenkins'
end

service 'jenkins' do
  action [:enable, :start]
end
