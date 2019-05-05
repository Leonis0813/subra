#
# Cookbook Name:: jenkins
# Recipe:: install
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package 'java-1.8.0-openjdk' do
  not_if 'rpm -q java'
end

remote_file node[:jenkins][:rpm_path] do
  source node[:jenkins][:rpm_url]
  owner 'root'
  group 'root'
  mode '0755'
  not_if { File.exists?(node[:jenkins][:rpm_path]) }
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
  mode '0600'
end

service 'jenkins' do
  action %i[enable start]
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
  mode '0755'
  not_if { File.exists?(node[:jenkins][:cli_path]) }
end

node[:jenkins][:accounts].each do |account|
  execute "create account - #{account[:id]}" do
    command <<-"EOF"
pass=`sudo cat #{node[:jenkins][:admin][:password_file]}`
echo 'jenkins.model.Jenkins.instance.securityRealm.createAccount("#{account[:id]}", "#{account[:password]}")' |
java -jar #{node[:jenkins][:cli_path]} -auth admin:${pass} -noKeyAuth -s #{node[:jenkins][:host]}/ groovy =
    EOF
    user 'root'
    retries 5
    retry_delay 10
  end
end

node[:jenkins][:plugins].each do |plugin|
  ruby_block "install plugin - #{plugin}" do
    block do
      xml = "<jenkins><install plugin=\"#{plugin}@latest\" /></jenkins>"
      content_type = {'Content-Type' => 'text/xml'}
      begin
        client.post('/pluginManager/installNecessaryPlugins', xml, basic_auth.merge(crumb).merge(content_type))
      rescue Exceptions::InvalidRedirect => e
        response = client.post('/updateCenter/', xml, basic_auth.merge(crumb).merge(content_type))
      end
    end
    retries 3
  end
end

include_recipe 'jenkins::job'
include_recipe 'jenkins::view'

ruby_block "wait plugins installed" do
  block do
    def get_plugins
      response = client.get('/pluginManager/api/json?depth=1', basic_auth)
      JSON.parse(response)['plugins'].map {|plugin| plugin['shortName'] }
    end

    10.times do
      plugins = get_plugins
      puts "installed plugins: #{node[:jenkins][:plugins] & plugins}"
      break if (node[:jenkins][:plugins] - plugins).empty?
      sleep 3
    end

    plugins = get_plugins
    raise Exception unless (node[:jenkins][:plugins] - plugins).empty?
  end
  retries 3
end

service 'jenkins' do
  action :restart
end
