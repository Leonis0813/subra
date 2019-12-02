default[:zosma][:app_name] = 'zosma'
default[:zosma][:deploy_dir] = "/opt/#{default[:zosma][:app_name]}"
default[:zosma][:repository] =
  "https://github.com/Leonis0813/#{default[:zosma][:app_name]}.git"
default[:zosma][:branch] = 'develop'
default[:zosma][:symlinks] = {'tmp' => 'tmp', 'log' => 'log', 'backup' => 'backup'}
default[:zosma][:shared_dirs] = %w[tmp backup log bundle]
default[:zosma][:requirements] = %w[cmake mysql-devel]
default[:zosma][:username] = 'analyzer'
default[:zosma][:smb] = {
  packages: %w[samba-client cifs-utils],
  share_name: 'share',
  mount_dir: '/mnt/smb',
  credential_file: '/etc/smb.cred',
}
default[:zosma][:ruby_version] = '2.6.3'
default[:zosma][:log_level] = 'info'
