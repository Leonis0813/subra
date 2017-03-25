#
# Cookbook Name:: nfs
# Recipe:: iptables
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#

execute "touch #{node[:nfs][:iptables_path]}"

node[:nfs][:iptable_settings].each do |setting|
  options = setting.map {|key, value| "--#{key} #{value}" }.join(' ')
  execute "iptables #{options}"
end

service 'iptables' do
  action [:restart]
end
