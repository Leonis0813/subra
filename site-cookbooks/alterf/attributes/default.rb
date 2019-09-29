default[:alterf][:app_name] = 'alterf'
default[:alterf][:deploy_dir] = "/opt/nginx/apps/#{default[:alterf][:app_name]}"
default[:alterf][:repository] =
  "https://github.com/Leonis0813/#{default[:alterf][:app_name]}.git"
default[:alterf][:branch] = 'develop'
default[:alterf][:symlinks] = {'log' => 'log', 'tmp' => 'tmp'}
default[:alterf][:shared_dirs] = %w[log bundle tmp/files]
default[:alterf][:requirements] = %w[librsvg2-devel mysql-devel]
default[:alterf][:ruby_version] = '2.5.5'
default[:alterf][:mysql_users] = %w[development test]
default[:alterf][:python] = {
  version: '3.6.6',
  packages: %w[dtreeviz mysql-connector-python-rf pandas pyyaml scikit-learn wheel],
}
default[:alterf][:geckodriver] = {
  base_url: 'https://github.com/mozilla/geckodriver/releases/download/v0.24.0',
  filename: 'geckodriver-v0.24.0-linux64.tar.gz',
  download_path: '/tmp/geckodriver.tar.gz',
}
