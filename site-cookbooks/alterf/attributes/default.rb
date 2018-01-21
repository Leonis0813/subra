default[:alterf][:app_name] = 'alterf'
default[:alterf][:deploy_dir] = "/opt/nginx/apps/#{default[:alterf][:app_name]}"
default[:alterf][:repository] = "https://github.com/Leonis0813/#{default[:alterf][:app_name]}.git"
default[:alterf][:branch] = 'develop'
default[:alterf][:symlinks] = {'log' => 'log', 'results' => 'results', 'tmp' => 'tmp'}
default[:alterf][:shared_dirs] = %w[ log bundle results tmp ]
default[:alterf][:requirements] = %w[ mysql-devel ]
default[:alterf][:ruby_version] = '2.2.0'
default[:alterf][:mysql_users] = %w[ development test ]
