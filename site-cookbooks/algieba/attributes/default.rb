default[:algieba][:app_name] = 'algieba'
default[:algieba][:deploy_dir] = "/opt/nginx/apps/#{default[:algieba][:app_name]}"
default[:algieba][:repository] =
  "https://github.com/Leonis0813/#{default[:algieba][:app_name]}.git"
default[:algieba][:branch] = 'develop'
default[:algieba][:symlinks] = {'tmp' => 'tmp', 'dump.sql' => 'db/dump.sql'}
default[:algieba][:shared_dirs] = %w[log tmp bundle]
default[:algieba][:ruby_version] = '2.7.2'
default[:algieba][:mysql_users] = %w[development test]
default[:algieba][:requirements] = %w[cmake mysql-devel]
default[:algieba][:geckodriver] = {
  base_url: 'https://github.com/mozilla/geckodriver/releases/download/v0.24.0',
  filename: 'geckodriver-v0.24.0-linux64.tar.gz',
  download_path: '/tmp/geckodriver.tar.gz',
}
