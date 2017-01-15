#
# Cookbook Name:: jenkins
# Recipe:: plugin
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

node[:jenkins][:plugins].each do |plugin|
  execute "install plugin  - #{plugin}" do
    command <<-"EOF"
java -jar #{node[:jenkins][:cli_path]} -s #{node[:jenkins][:host]} install-plugin #{plugin} --username=#{node[:jenkins][:admin][:username]} --password-file=#{node[:jenkins][:admin][:password_file]}
    EOF
    user 'root'
    retries 5
    retry_delay 10
  end
end
