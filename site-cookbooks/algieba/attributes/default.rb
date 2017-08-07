default[:algieba][:app_name] = 'algieba'
default[:algieba][:deploy_dir] = "/opt/nginx/apps/#{default[:algieba][:app_name]}"
default[:algieba][:repository] = "https://github.com/Leonis0813/#{default[:algieba][:app_name]}.git"
default[:algieba][:branch] = 'develop'
default[:algieba][:symlinks] = {'log' => 'log', 'tmp' => 'tmp', 'dump.sql' => 'db/dump.sql'}
default[:algieba][:shared_dirs] = %w[ log tmp bundle ]
default[:algieba][:ruby_version] = '2.2.0'
default[:algieba][:open_ports] = %w[ 80:tcp 3000:tcp ]
default[:algieba][:mysql_users] = %w[ development test ]
