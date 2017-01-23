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

%w[ sphinx==1.4.5 sphinxcontrib-plantuml sphinxcontrib-httpdomain ].each do |package|
  execute "pip install #{package}"
end
