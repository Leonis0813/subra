default[:gpg][:server] = 'https://rvm.io/mpapis.asc'
default[:rvm] = {
  :server => 'https://get.rvm.io',
  :install_dir => '/usr/local/rvm',
}
default[:rvm][:path] = '/usr/local/rvm/bin:/usr/bin:/bin'
