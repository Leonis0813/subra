#
# Cookbook Name:: jenkins
# Recipe:: install
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package node[:jenkins][:requirements]

remote_file node[:jenkins][:rpm_path] do
  source node[:jenkins][:rpm_url]
  owner 'root'
  group 'root'
  mode '0755'
  not_if { File.exist?(node[:jenkins][:rpm_path]) }
end

package 'jenkins' do
  source node[:jenkins][:rpm_path]
  not_if 'rpm -q jenkins'
end

create_sudoer 'jenkins'

config_file = File.absolute_path(File.dirname(__FILE__) + '/../files/default/jenkins')
file '/etc/sysconfig/jenkins' do
  content IO.read(config_file)
  owner 'root'
  group 'root'
  mode '0600'
end

service 'jenkins' do
  action %i[enable start]
end

execute 'ss -ant | grep 8080 | grep LISTEN' do
  retries 5
  retry_delay 10
end

remote_file node[:jenkins][:cli_path] do
  source node[:jenkins][:cli_url]
  owner 'root'
  group 'root'
  mode '0755'
  not_if { File.exist?(node[:jenkins][:cli_path]) }
end

node[:jenkins][:accounts].each do |account|
  execute "create account - #{account[:id]}" do
    command <<-"COMMAND"
pass=`sudo cat #{node[:jenkins][:admin][:password_file]}`
echo 'jenkins.model.Jenkins.instance.securityRealm.createAccount("#{account[:id]}", "#{account[:password]}")' |
java -jar #{node[:jenkins][:cli_path]} -auth admin:${pass} -noKeyAuth -s #{node[:jenkins][:host]}/ groovy =
    COMMAND
    user 'root'
    retries 5
    retry_delay 10
  end
end

node[:jenkins][:plugins].each do |plugin|
  ruby_block "install plugin - #{plugin}" do
    block do
      xml = <<"EOF"
<jenkins>
  <install plugin="#{plugin['id']}@#{plugin['version']}" />
</jenkins>
EOF
      content_type = {'Content-Type' => 'text/xml'}
      begin
        header = basic_auth.merge(crumb).merge(content_type)
        client.post('/pluginManager/installNecessaryPlugins', xml, header)
      rescue Exceptions::InvalidRedirect
        client.post('/updateCenter/', xml, header)
      end
    end
    retries 3
  end
end

ruby_block 'wait plugins installed' do
  block do
    def http_get_plugins
      response = client.get('/pluginManager/api/json?depth=1', basic_auth)
      JSON.parse(response)['plugins'].map {|plugin| plugin['shortName'] }
    end

    plugins = node[:jenkins][:plugins].map {|plugin| plugin[:id] }

    10.times do
      installed_plugins = http_get_plugins
      puts "installed plugins: #{plugins & installed_plugins}"
      break if (plugins - installed_plugins).empty?

      sleep 3
    end

    installed_plugins = http_get_plugins
    raise Exception unless (plugins - installed_plugins).empty?
  end
  retries 3
end

include_recipe 'jenkins::job'

service 'jenkins' do
  action :restart
end
