default[:gpg][:server] = 'https://rvm.io/mpapis.asc'
default[:rvm] = {
  server: 'https://get.rvm.io',
  install_dir: '/usr/local/rvm',
  path: '/usr/local/rvm/bin:/usr/bin:/bin',
}
default[:rvm][:install_commands] = [
  "curl -sSL #{default[:gpg][:server]} | gpg --import -",
  "curl -sSL #{default[:rvm][:server]} | sudo bash -s stable",
  "#{default[:rvm][:install_dir]}/bin/rvm reload",
]
