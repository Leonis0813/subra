#
# Cookbook Name:: emacs
# Recipe:: install
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
package %w[ gcc make ncurses-devel ] do
  action :install
end

remote_file '/tmp/emacs-24.5.tar.gz' do
  source 'http://ftp.gnu.org/pub/gnu/emacs/emacs-24.5.tar.gz'
end

execute 'tar zxf emacs-24.5.tar.gz' do
  cwd '/tmp'
end

execute 'install emacs' do
  command <<-EOF
./configure --without-x
make
sudo make install
  EOF
  cwd '/tmp/emacs-24.5'
end

file '/tmp/emacs-24.5.tar.gz' do
  action :delete
end

directory '/tmp/emacs-24.5' do
  recursive true
  action :delete
end
