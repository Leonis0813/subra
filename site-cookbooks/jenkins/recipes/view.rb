#
# Cookbook Name:: jenkins
# Recipe:: view
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

node[:jenkins][:views].each do |view|
  config_file = File.absolute_path(File.dirname(__FILE__) + "/../files/default/views/#{view}.xml")
  execute "create view - #{view}" do
    command <<-EOF
cat #{config_file} |
java -jar #{node[:jenkins][:cli_path]} -s #{node[:jenkins][:host]} create-view #{view} --username=#{node[:jenkins][:admin][:username]} --password-file=#{node[:jenkins][:admin][:password_file]}
    EOF
    user 'root'
    retries 5
    retry_delay 10
    not_if "java -jar #{node[:jenkins][:cli_path]} -s #{node[:jenkins][:host]} get-view #{view} --username=#{node[:jenkins][:admin][:username]} --password-file=#{node[:jenkins][:admin][:password_file]}"
  end
end
