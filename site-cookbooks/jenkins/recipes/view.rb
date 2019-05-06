#
# Cookbook Name:: jenkins
# Recipe:: view
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
node[:jenkins][:views].each do |view|
  ruby_block "update view - #{view}" do
    block do
      xml_file = File.absolute_path(
        File.dirname(__FILE__) + "/../files/default/views/#{view}.xml",
      )
      begin
        content_type = {'Content-Type' => 'text/xml'}
        header = content_type.merge(basic_auth.merge(crumb))
        client.post("/view/#{view}/config.xml", IO.read(xml_file), header)
      rescue Net::HTTPServerException => e
        raise e unless  e.message == '404 "Not Found"'
      end
    end
  end
end
