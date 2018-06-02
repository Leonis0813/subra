#
# Cookbook Name:: rstudio
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package %w[epel-release R]

remote_file '/tmp/rstudio-server-rhel-1.1.453-x86_64.rpm' do
  source 'https://download2.rstudio.org/rstudio-server-rhel-1.1.453-x86_64.rpm'
  owner 'root'
  group 'root'
  mode 0755
  not_if { File.exists?('/tmp/rstudio-server-rhel-1.1.453-x86_64.rpm') }
end

package 'rstudio' do
  source '/tmp/rstudio-server-rhel-1.1.453-x86_64.rpm'
  not_if 'rpm -q rstudio'
end

execute 'rstudio-server stop' do
  ignore_failure true
end

execute 'rstudio-server start'
