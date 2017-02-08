#
# Cookbook Name:: jenkins
# Recipe:: job
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
remote_file node[:jenkins][:cli_path] do
  source node[:jenkins][:cli_url]
  owner 'root'
  group 'root'
  mode 0755
  not_if { File.exists?(node[:jenkins][:cli_path]) }
end

node[:jenkins][:jobs].each do |job|
  config_file = File.absolute_path(File.dirname(__FILE__) + "/../files/default/#{node.chef_environment}/#{job}.xml")
  execute "create job - #{job}" do
    command <<-EOF
cat #{config_file} |
java -jar #{node[:jenkins][:cli_path]} -s #{node[:jenkins][:host]} create-job #{job} --username=#{node[:jenkins][:admin][:username]} --password-file=#{node[:jenkins][:admin][:password_file]}
    EOF
    user 'root'
    retries 5
    retry_delay 10
    not_if "java -jar #{node[:jenkins][:cli_path]} -s #{node[:jenkins][:host]} list-jobs --username=#{node[:jenkins][:admin][:username]} --password-file=#{node[:jenkins][:admin][:password_file]} | grep -e '^#{job}$'"
  end
end
