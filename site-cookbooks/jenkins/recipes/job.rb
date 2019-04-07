#
# Cookbook Name:: jenkins
# Recipe:: job
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#

node[:jenkins][:deploy_jobs].each do |deploy_job|
  template 'tmp/config.xml' do
    source 'jobs/deploy.xml.erb'
    owner 'root'
    group 'root'
    mode '0755'
    variables :app_info => node[:zosma]
  end

  update_job do
    job_name deploy_job
    file_name 'tmp/config.xml'
  end
end

node[:jenkins][:jobs].each do |job|
  update_job do
    job_name job
    file_name config(node.chef_environment, job)
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
