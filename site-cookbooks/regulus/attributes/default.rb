default[:regulus][:app_name] = 'regulus'
default[:regulus][:deploy_dir] = "/opt/#{default[:regulus][:app_name]}"
default[:regulus][:repository] = "https://github.com/Leonis0813/#{default[:regulus][:app_name]}.git"
default[:regulus][:branch] = 'develop'
default[:regulus][:username] = 'analyzer'
default[:regulus][:password] = '7QiSlC?4'
default[:regulus][:smb][:share_name] = '//27.134.255.192/share'
default[:regulus][:smb][:mount_dir] = '/mnt/smb'
default[:regulus][:cron_settings] = [
  {:name => 'import', :hour => '0', :minute => '0'},
  {:name => 'aggregate'},
]
default[:regulus][:cron_paths] = [
  '/usr/local/rvm/gems/ruby-2.2.0@global/bin',
  '/usr/local/rvm/rubies/ruby-2.2.0/bin',
  '/usr/bin',
  '/bin',
]
