#
# Cookbook Name:: alterf
# Recipe:: cron
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
node[:alterf][:cron_settings].each do |cron_setting|
  cron "#{node[:alterf][:app_name]} #{cron_setting[:name]}" do
    command [
      'cd /opt/alterf/current &&',
      "bundle exec ruby #{cron_setting[:name]}.rb",
    ].join(' ')
    hour cron_setting[:hour]
    minute cron_setting[:minute]
    path node[:alterf][:cron_paths].join(':')
  end
end
