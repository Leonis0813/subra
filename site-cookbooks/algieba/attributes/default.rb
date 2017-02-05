default[:algieba][:app_name] = 'algieba'
default[:algieba][:deploy_dir] = "/opt/nginx/apps/#{default[:algieba][:app_name]}"
default[:algieba][:repository] = "https://github.com/Leonis0813/#{default[:algieba][:app_name]}.git"
default[:algieba][:branch] = 'develop'
default[:algieba][:symlinks] = {'log' => 'log', 'tmp' => 'tmp'}
default[:algieba][:shared_dirs] = %w[ log tmp ]
