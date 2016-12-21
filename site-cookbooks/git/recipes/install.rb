#
# Cookbook Name:: git
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package %w[ curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-ExtUtils-MakeMaker ] do
  action :install
end

remote_file '/tmp/git-2.11.0.tar.gz' do
  source 'https://www.kernel.org/pub/software/scm/git/git-2.11.0.tar.gz'
end

execute 'tar zxf git-2.11.0.tar.gz' do
  cwd '/tmp'
end

execute 'install git' do
  command <<-EOF
make prefix=/usr/local all
make prefix=/usr/local install
  EOF
  cwd '/tmp/git-2.11.0'
end

file '/tmp/git-2.11.0.tar.gz' do
  action :delete
end

directory '/tmp/git-2.11.0' do
  recursive true
  action :delete
end
