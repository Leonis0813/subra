#
# Cookbook Name:: regulus
# Recipe:: mount
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
node[:regulus][:mount_settings].each do |setting|
  directory setting[:path] do
    user 'root'
    group 'root'
    mode 0755
    not_if { File.exists?(setting[:path]) }
  end

  mount setting[:path] do
    fstype setting[:fstype]
    device_type setting[:device_type]
    device setting[:device]
    action [:mount, :enable]
  end
end
