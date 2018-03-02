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
        raise e unless  e.message == '404 "Not Found"'
      end
    end
  end
end
