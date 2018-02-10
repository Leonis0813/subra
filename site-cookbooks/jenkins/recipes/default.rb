#
# Cookbook Name:: jenkins
# Recipe:: install
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
remote_file node[:jenkins][:rpm_path] do
  source node[:jenkins][:rpm_url]
  owner 'root'
  group 'root'
  mode 0755
  not_if { File.exists?(node[:jenkins][:rpm_path]) }
end

package 'java-1.8.0-openjdk' do
  not_if 'rpm -q java'
end

package 'jenkins' do
  source node[:jenkins][:rpm_path]
  not_if 'rpm -q jenkins'
end

create_sudoer 'jenkins'

file '/etc/sysconfig/jenkins' do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/jenkins'))
  owner 'root'
  group 'root'
  mode 0600
end

service 'jenkins' do
  action [:enable, :start]
end

execute 'netstat -ant | grep 8080 | grep LISTEN' do
  retries 5
  retry_delay 10
end

service 'network' do
  action :restart
end

remote_file node[:jenkins][:cli_path] do
  source node[:jenkins][:cli_url]
  owner 'root'
  group 'root'
  mode 0755
  not_if { File.exists?(node[:jenkins][:cli_path]) }
end

node[:jenkins][:accounts].each do |account|
  execute "create account - #{account[:id]}" do
    command <<-"EOF"
echo 'jenkins.model.Jenkins.instance.securityRealm.createAccount("#{account[:id]}", "#{account[:password]}")' |
java -jar #{node[:jenkins][:cli_path]} -s #{node[:jenkins][:host]} groovy = --username=#{node[:jenkins][:admin][:username]} --password-file=#{node[:jenkins][:admin][:password_file]}
    EOF
    user 'root'
    retries 5
    retry_delay 10
  end
end

node[:jenkins][:plugins].each do |plugin|
  execute "install plugin - #{plugin}" do
    command <<-"EOF"
java -jar #{node[:jenkins][:cli_path]} -s #{node[:jenkins][:host]} install-plugin #{plugin} --username=#{node[:jenkins][:admin][:username]} --password-file=#{node[:jenkins][:admin][:password_file]}
    EOF
    user 'root'
    retries 5
  end
end
