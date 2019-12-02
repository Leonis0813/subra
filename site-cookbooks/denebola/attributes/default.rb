default[:denebola][:app_name] = 'denebola'
default[:denebola][:deploy_dir] = "/opt/#{default[:denebola][:app_name]}"
default[:denebola][:repository] =
  "https://github.com/Leonis0813/#{default[:denebola][:app_name]}.git"
default[:denebola][:branch] = 'develop'
default[:denebola][:symlinks] = {'backup' => 'backup'}
default[:denebola][:shared_dirs] = %w[backup/race_list backup/races log bundle]
default[:denebola][:requirements] = %w[cmake mysql-devel]
default[:denebola][:ruby_version] = '2.6.3'
default[:denebola][:export_dir] = '/etc/exports.d'
default[:denebola][:exports] = [
  {
    path: "#{default[:denebola][:deploy_dir]}/backup",
    ips: '*',
    options: %w[rw no_root_squash],
  },
]
default[:denebola][:log_level] = 'info'
default[:denebola][:database] = [
  {env: 'development', name: 'denebola'},
]
