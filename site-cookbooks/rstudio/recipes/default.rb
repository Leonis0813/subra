#
# Cookbook Name:: rstudio
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package %w[epel-release R]

remote_file "/tmp/#{node[:rstudio][:rpm_file]}" do
  source "https://download2.rstudio.org/#{node[:rstudio][:rpm_file]}"
  owner 'root'
  group 'root'
  mode 0755
  not_if { File.exists?("/tmp/#{node[:rstudio][:rpm_file]}") }
end

package 'rstudio' do
  source "/tmp/#{node[:rstudio][:rpm_file]}"
  not_if 'rpm -q rstudio'
end

execute 'rstudio-server stop' do
  ignore_failure true
end

execute 'rstudio-server start'
