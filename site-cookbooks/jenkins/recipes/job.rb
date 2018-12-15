#
# Cookbook Name:: jenkins
# Recipe:: job
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#

node[:jenkins][:jobs].each do |job|
  ruby_block "update job - #{job}" do
    block do
      xml = config(node.chef_environment, job)
      begin
        client.post("/job/#{job}/config.xml", IO.read(xml), basic_auth.merge(crumb))
      rescue Net::HTTPServerException => e
        if e.message == '404 "Not Found"'
          body = IO.read(config(node.chef_environment, job))
          header = {'Content-Type' => 'text/xml'}.merge(basic_auth).merge(crumb)
          client.post("/createItem?name=#{job}", body, header)
        else
          raise e
        end
      end
    end
  end
end

directory node[:jenkins][:tools_dir]

node[:jenkins][:github][:scripts].each do |script|
  template File.join(node[:jenkins][:tools_dir], script) do
    source "#{script}.erb"
    owner 'root'
    group 'root'
    mode '0755'
  end
end

template File.join(node[:jenkins][:home], '.netrc') do
  source 'netrc.erb'
  owner 'jenkins'
  mode '0644'
end
