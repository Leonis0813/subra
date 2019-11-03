default[:regulus][:app_name] = 'regulus'
default[:regulus][:deploy_dir] = "/opt/nginx/apps/#{default[:regulus][:app_name]}"
default[:regulus][:repository] =
  "https://github.com/Leonis0813/#{default[:regulus][:app_name]}.git"
default[:regulus][:branch] = 'develop'
default[:regulus][:symlinks] = {
  'config/prediction.yml' => 'config/prediction.yml',
  'log' => 'log',
  'tmp' => 'tmp',
}
default[:regulus][:shared_dirs] = %w[
  bundle
  config
  log
  tmp
  tmp/files
  tmp/models
  tmp/models/tensorboard
]
default[:regulus][:requirements] = %w[cmake mysql-devel cronie-noanacron]
default[:regulus][:ruby_version] = '2.5.5'
default[:regulus][:mysql_users] = %w[development test]
default[:regulus][:geckodriver] = {
  base_url: 'https://github.com/mozilla/geckodriver/releases/download/v0.24.0',
  filename: 'geckodriver-v0.24.0-linux64.tar.gz',
  download_path: '/tmp/geckodriver.tar.gz',
}
default[:regulus][:python] = {
  version: '3.6.6',
  packages: %w[mysql-connector-python-rf pandas pyyaml wheel],
}
default[:regulus][:tensorflow] = {
  base_url: 'https://storage.googleapis.com/tensorflow/linux/cpu',
  filename: 'tensorflow-1.13.1-cp36-cp36m-linux_x86_64.whl',
}
