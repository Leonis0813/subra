#
# Cookbook Name:: nginx
# Recipe:: html
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#

bootstrap_download = node[:nginx][:bootstrap][:download]
download_path = File.join(bootstrap_download[:dir], bootstrap_download[:file])

remote_file download_path do
  source bootstrap_download[:url]
  not_if { File.exists?(download_path) }
end

package 'unzip'

execute "unzip -o #{download_path} -d #{node[:nginx][:install_dir]}/html"

node[:nginx][:html_files].each do |html_file|
  template "#{node[:nginx][:install_dir]}/html/#{html_file}.html" do
    owner 'nginx'
    group 'nginx'
    mode 0644
    variables(:links => node[:nginx][:portal][:links])
  end
end

service 'nginx' do
  action :restart
end
