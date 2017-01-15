#
# Cookbook Name:: jenkins
# Recipe:: user
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
