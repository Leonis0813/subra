#
# Cookbook Name:: sphinx
# Recipe:: install
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package %w[ python-pip graphviz ] do
  action :install
end

%w[ sphinxcontrib-plantuml sphinxcontrib-httpdomain ].each do |package|
  execute "easy_install #{package}"
end

execute 'pip install sphinx'
