default[:rvm][:requirements] = %w[sudo which]
default[:rvm][:install_dir] = '/usr/local/rvm'
default[:rvm][:install_commands] = [
  'curl -sSL https://rvm.io/mpapis.asc | gpg --import -',
  'curl -sSL https://get.rvm.io | sudo bash -s stable',
  "#{default[:rvm][:install_dir]}/bin/rvm reload",
]
