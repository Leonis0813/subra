#
# Cookbook Name:: nginx
# Recipe:: html
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
node[:nginx][:html_files].each do |html_file|
  template "#{node[:nginx][:install_dir]}/html/#{html_file}.html" do
    owner 'nginx'
    group 'nginx'
    mode 0644
    variables(:host => Chef::EncryptedDataBagItem.load('nginx', 'sakura')['ip_address'])
  end
end

service 'nginx' do
  action :restart
end
