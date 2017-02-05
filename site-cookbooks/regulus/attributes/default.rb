default[:regulus][:app_name] = 'regulus'
default[:regulus][:deploy_dir] = "/opt/#{default[:regulus][:app_name]}"
default[:regulus][:repository] = "https://github.com/Leonis0813/#{default[:regulus][:app_name]}.git"
default[:regulus][:branch] = 'develop'
default[:regulus][:symlinks] = {'tmp' => 'tmp', 'log' => 'log', 'backup' => 'backup'}
default[:regulus][:shared_dirs] = %w[ tmp backup log bundle ]
default[:regulus][:username] = 'analyzer'
default[:regulus][:password] = '7QiSlC?4'
default[:regulus][:smb] = {
  :packages => %w[ samba-client cifs-utils ],
  :share_name => '//27.134.255.192/share',
  :mount_dir => '/mnt/smb',
  :credential_file => '/etc/smb.cred',
}
default[:regulus][:cron_settings] = [
  {:name => 'aggregate', :hour => '0', :minute => '0'},
]
default[:regulus][:cron_paths] = [
  '/usr/local/rvm/gems/ruby-2.2.0@global/bin',
  '/usr/local/rvm/rubies/ruby-2.2.0/bin',
  '/usr/bin',
  '/bin',
]
default[:regulus][:ruby_version] = '2.2.0'
