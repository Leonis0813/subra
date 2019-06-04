default[:sphinx][:requirements] = %w[python-pip graphviz ipa-gothic-fonts]
default[:sphinx][:packages] = %w[
  sphinx==1.4.5
  sphinxcontrib-plantuml
  sphinxcontrib-httpdomain
]
default[:sphinx][:pyenv] = {
  root: '/usr/local/pyenv',
  repository: 'https://github.com/pyenv/pyenv.git',
  revision: 'v1.2.6',
}
default[:sphinx][:python][:version] = '3.6.0'
