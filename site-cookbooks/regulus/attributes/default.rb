default[:regulus][:app_name] = 'regulus'
default[:regulus][:deploy_dir] = "/opt/#{default[:regulus][:app_name]}"
default[:regulus][:repository] = "https://github.com/Leonis0813/#{default[:regulus][:app_name]}.git"
default[:regulus][:branch] = 'develop'
default[:regulus][:symlinks] = {'tmp' => 'tmp', 'log' => 'log', 'backup' => 'backup', 'results' => 'results'}
default[:regulus][:shared_dirs] = %w[ tmp backup log bundle results ]
default[:regulus][:requirements] = %w[ mysql-devel ]
default[:regulus][:username] = 'analyzer'
default[:regulus][:smb] = {
  :packages => %w[ samba-client cifs-utils ],
  :share_name => 'share',
  :mount_dir => '/mnt/smb',
  :credential_file => '/etc/smb.cred',
}
default[:regulus][:ruby_version] = '2.2.0'
default[:regulus][:mount_settings] = [
  {
    :path => "/mnt/sakura/#{default[:regulus][:app_name]}",
    :fstype => 'nfs',
    :device_type => :device,
    :device => "#{Chef::EncryptedDataBagItem.load('regulus', 'sakura')['ip_address']}:#{default[:regulus][:deploy_dir]}/shared/backup",
  },
  {
    :path => '/mnt/backup',
    :fstype => 'ext4',
    :device_type => :uuid,
    :device => 'a64322c0-3fcc-4407-a423-51e21e05be28',
  },
]
default[:regulus][:export_dir] = '/etc/exports.d'
default[:regulus][:exports] = [
  {:path => "#{default[:regulus][:deploy_dir]}/backup", :ips => '*', :options => %w[ rw no_root_squash ]}
]
default[:regulus][:mysql_users] = %w[ development test ]
