default[:alterf][:app_name] = 'alterf'
default[:alterf][:deploy_dir] = "/opt/#{default[:alterf][:app_name]}"
default[:alterf][:repository] = "https://github.com/Leonis0813/#{default[:alterf][:app_name]}.git"
default[:alterf][:branch] = 'develop'
default[:alterf][:symlinks] = {'log' => 'log', 'backup' => 'backup', 'results' => 'results'}
default[:alterf][:shared_dirs] = %w[ backup/race_list backup/races backup/horses log bundle results ]
default[:alterf][:requirements] = %w[ mysql-devel ]
default[:alterf][:ruby_version] = '2.2.0'
default[:alterf][:mount_settings] = [
  {
    :path => "/mnt/sakura/#{default[:alterf][:app_name]}",
    :fstype => 'nfs',
    :device_type => :device,
    :device => "#{Chef::EncryptedDataBagItem.load('alterf', 'sakura')['ip_address']}:#{default[:alterf][:deploy_dir]}/shared/backup",
  },
  {
    :path => '/mnt/backup',
    :fstype => 'ext4',
    :device_type => :uuid,
    :device => 'a64322c0-3fcc-4407-a423-51e21e05be28',
  },
]
default[:alterf][:export_dir] = '/etc/exports.d'
default[:alterf][:exports] = [
  {:path => "#{default[:alterf][:deploy_dir]}/backup", :ips => '*', :options => %w[ rw no_root_squash ]}
]
