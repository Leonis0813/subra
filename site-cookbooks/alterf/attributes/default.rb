default[:alterf][:app_name] = 'alterf'
default[:alterf][:deploy_dir] = "/opt/nginx/apps/#{default[:alterf][:app_name]}"
default[:alterf][:repository] =
  "https://github.com/Leonis0813/#{default[:alterf][:app_name]}.git"
default[:alterf][:branch] = 'develop'
default[:alterf][:symlinks] = {'log' => 'log', 'tmp' => 'tmp'}
default[:alterf][:shared_dirs] = %w[log bundle tmp/files]
default[:alterf][:requirements] = %w[mysql-devel]
default[:alterf][:ruby_version] = '2.4.4'
default[:alterf][:mysql_users] = %w[development test]
default[:alterf][:features] = %w[
  age
  burden_weight
  direction
  distance
  grade
  number
  place
  race_id
  round
  track
  weather
  weight
  weight_diff
]
