default[:rvm][:requirements] = %w[sudo which]
default[:rvm][:path] = '/usr/local/rvm/bin:/usr/bin:/bin'
default[:rvm][:install_dir] = '/usr/local/rvm'
default[:rvm][:install_commands] = [
  'curl -sSL https://rvm.io/mpapis.asc | sudo gpg2 --import -',
  'curl -sSL https://rvm.io/pkuczynski.asc | sudo gpg2 --import -',
  'curl -sSL https://get.rvm.io | sudo bash -s stable',
  "#{default[:rvm][:install_dir]}/bin/rvm reload",
]
