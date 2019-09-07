default[:regulus][:app_name] = 'regulus'
default[:regulus][:deploy_dir] = "/opt/nginx/apps/#{default[:regulus][:app_name]}"
default[:regulus][:repository] =
  "https://github.com/Leonis0813/#{default[:regulus][:app_name]}.git"
default[:regulus][:branch] = 'develop'
default[:regulus][:symlinks] = {'tmp' => 'tmp', 'log' => 'log'}
default[:regulus][:shared_dirs] = %w[tmp log bundle tmp/files tmp/models]
default[:regulus][:requirements] = %w[cmake mysql-devel cronie-noanacron]
default[:regulus][:ruby_version] = '2.5.5'
default[:regulus][:open_ports] = %w[80:tcp 3000:tcp]
default[:regulus][:mysql_users] = %w[development test]
default[:regulus][:geckodriver] = {
  base_url: 'https://github.com/mozilla/geckodriver/releases/download',
  version: 'v0.24.0',
  download_path: '/tmp/geckodriver.tar.gz',
}
default[:regulus][:python] = {
  version: '3.6.6',
  packages: %w[wheel mysql-connector-python-rf pyyaml]
}
default[:regulus][:tensorflow] = {
  base_url: 'https://storage.googleapis.com/tensorflow/linux/cpu',
  filename: 'tensorflow-1.13.1-cp36-cp36m-linux_x86_64.whl',
}
