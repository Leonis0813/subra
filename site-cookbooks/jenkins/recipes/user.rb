#
# Cookbook Name:: jenkins
# Recipe:: user
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
remote_file "/tmp/jenkins-cli.jar" do
  source 'http://localhost:8080/jnlpJars/jenkins-cli.jar'
  owner 'root'
  group 'root'
  mode 0755
  not_if { File.exists?("/tmp/jenkins-cli.jar") }
end

execute 'create account' do
  command <<-EOF
echo 'jenkins.model.Jenkins.instance.securityRealm.createAccount("leonis", "7QiSlC?4")' |
java -jar /tmp/jenkins-cli.jar -s http://localhost:8080 groovy = --username=admin --password=6026710acdec4fb3a0997fdc05afd129
  EOF
  user 'root'
  retries 5
end
