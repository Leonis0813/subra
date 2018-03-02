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
      client = Chef::HTTP.new(node[:jenkins][:host])
      path = '/crumbIssuer/api/json'
      account = node[:jenkins][:accounts].first
      credential = Base64.strict_encode64("#{account[:id]}:#{account[:password]}")
      header = {'Authorization' => "Basic #{credential}"}
      response = client.get(path, header)
      crumb = {'Jenkins-Crumb' => JSON.parse(response)['crumb']}
      config_file = File.absolute_path(File.dirname(__FILE__) + "/../files/default/jobs/#{node.chef_environment}/#{job}.xml")
      begin
        client.post("/job/#{job}/config.xml", IO.read(config_file), header.merge(crumb))
      rescue Net::HTTPServerException => e
        raise e unless  e.message == '404 "Not Found"'
      end
    end
  end
end
