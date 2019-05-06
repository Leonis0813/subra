default[:regulus][:app_name] = 'regulus'
default[:regulus][:deploy_dir] = "/opt/nginx/apps/#{default[:regulus][:app_name]}"
default[:regulus][:repository] =
  "https://github.com/Leonis0813/#{default[:regulus][:app_name]}.git"
default[:regulus][:branch] = 'develop'
default[:regulus][:symlinks] = {'tmp' => 'tmp', 'log' => 'log'}
default[:regulus][:shared_dirs] = %w[tmp log bundle tmp/files tmp/models]
default[:regulus][:requirements] = %w[mysql-devel]
default[:regulus][:ruby_version] = '2.4.4'
default[:regulus][:mysql_users] = %w[development test]
default[:regulus][:python_packages] = %w[mysql-connector-python-rf]
