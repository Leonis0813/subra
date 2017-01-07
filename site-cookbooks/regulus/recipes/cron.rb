#
# Cookbook Name:: regulus
# Recipe:: cron
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
node[:regulus][:cron_settings].each do |cron_setting|
  cron "#{node[:regulus][:app_name]} #{cron_setting[:name]}" do
    command [
      'cd /opt/regulus/current &&',
      "bundle exec ruby #{cron_setting[:name]}.rb",
    ].join(' ')
    hour cron_setting[:hour]
    minute cron_setting[:minute]
    path node[:regulus][:cron_paths].join(':')
  end
end

cron "#{node[:regulus][:app_name]} delete" do
  commnad 'cd /opt/regulus/current && ruby delete.rb'
  hout '1'
  minute '0'
  path node[:regulus][:cron_paths].join(':')
  only_if { node[:regulus][:delete_old_files] }
end
