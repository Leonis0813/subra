#
# Cookbook Name:: jenkins
# Recipe:: job
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#

node[:jenkins][:polling_jobs].each do |job_name|
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

node[:jenkins][:deploy_jobs].each do |job_name|
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

node[:jenkins][:other_jobs].each do |job_name|
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

file File.join(node[:jenkins][:tools_dir], 'update_changelog.rb') do
  content IO.read(File.absolute_path(File.dirname(__FILE__) + '/../files/default/update_changelog.rb'))
  owner 'root'
  group 'root'
  mode '0755'
end
