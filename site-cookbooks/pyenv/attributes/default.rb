default[:pyenv][:root] = '/usr/local/pyenv'
default[:pyenv][:repository] = 'https://github.com/pyenv/pyenv.git'
default[:pyenv][:revision] = 'v1.2.6'
default[:pyenv][:virtualenv] = {
  root: "#{default[:pyenv][:root]}/plugins/pyenv-virtualenv",
  repository: 'https://github.com/yyuu/pyenv-virtualenv.git',
  revision: 'v1.1.3',
}
