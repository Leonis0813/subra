#
# Cookbook Name:: chort
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
deploy node[:chort][:deploy_dir] do
  repo node[:chort][:repository]
  branch ENV['CHORT_VERSION'] || node[:chort][:branch]
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks.clear
end

execute 'make html' do
  cwd "#{node[:chort][:deploy_dir]}/current"
end

directory "#{node[:nginx][:install_dir]}/html/docs" do
  recursive true
end

node[:chort][:doc_names].each do |doc_name|
  link "#{node[:nginx][:install_dir]}/html/docs/#{doc_name}" do
    to File.join(node[:chort][:deploy_dir], "current/#{doc_name}/_build/html")
  end
end
