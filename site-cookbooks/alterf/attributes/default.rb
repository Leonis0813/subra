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
kdefault[:alterf][:analysis][:racewise_features] = %w[
  average_prize_money
  burden_weight
  rate_within_third
  weight
  weight_diff
  weight_per
  win_times
]
default[:alterf][:prediction][:race_features] = %w[
  distance
  direction
  grade
  month
  place
  round
  track
  weather
]
default[:alterf][:prediction][:horse_features] = %w[
  age
  average_prize_money
  blank
  burden_weight
  distance_diff
  entry_times
  last_race_order
  number
  rate_within_third
  running_style
  second_last_race_order
  sex
  weight
  weight_diff
  weight_per
  win_times
]
