#
# Cookbook Name:: jenkins
# Recipe:: job
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#

node[:jenkins][:job][:polling].each do |job_name|
  template 'tmp/config.xml' do
    source 'jobs/polling.xml.erb'
    owner 'root'
    group 'root'
    mode '0755'
    variables app_info: node[job_name]
  end

  upsert_job do
    job_name job_name
    file_name 'tmp/config.xml'
  end
end

node[:jenkins][:job][:deploy].each do |job_name|
  template 'tmp/config.xml' do
    source 'jobs/deploy.xml.erb'
    owner 'root'
    group 'root'
    mode '0755'
    variables app_info: node[job_name.split('-').first]
  end

  upsert_job do
    job_name job_name
    file_name 'tmp/config.xml'
  end
end

node[:jenkins][:job][:check_pull_request].each do |job_name|
  template 'tmp/check_pull_request.xml' do
    source 'jobs/check_pull_request.xml.erb'
    owner 'root'
    group 'root'
    mode '0755'
    variables app_info: node[job_name.split('-').first]
  end

  upsert_job do
    job_name job_name
    file_name 'tmp/check_pull_request.xml'
  end
end

node[:jenkins][:job][:other].each do |job_name|
  upsert_job do
    job_name job_name
    file_name config(node.chef_environment, job_name)
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

script_file = File.absolute_path(
  File.dirname(__FILE__) + '/../files/default/update_changelog.rb',
)
file File.join(node[:jenkins][:tools_dir], 'update_changelog.rb') do
  content IO.read(script_file)
  owner 'root'
  group 'root'
  mode '0755'
end
