#
# Cookbook Name:: sphinx
# Recipe:: default
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
pyenv = node[:sphinx][:pyenv]
python = node[:sphinx][:python]

git pyenv[:root] do
  repository pyenv[:repository]
  revision pyenv[:revision]
  not_if { File.exist?(pyenv[:root]) }
end

['init -', "install #{python[:version]}"].each do |command|
  execute "pyenv #{command}" do
    environment 'PYENV_ROOT' => pyenv[:root],
                'PATH' => "#{pyenv[:root]}/bin:/usr/bin:/bin"
    not_if { File.exist?("#{pyenv[:root]}/versions/#{python[:version]}") }
  end
end

package node[:sphinx][:requirements]

node[:sphinx][:packages].each do |package|
  execute "pyenv global #{python[:version]} && pip install #{package}" do
    environment 'PYENV_ROOT' => pyenv[:root],
                'PATH' => [
                  "#{pyenv[:root]}/versions/#{python[:version]}/bin",
                  "#{pyenv[:root]}/bin",
                  '/usr/bin',
                  '/bin',
                ].join(':')
    not_if [
      "pyenv global #{python[:version]} && pip list",
      'cut -d " " -f 1',
      "grep -i #{package.split('==').first}",
    ].join(' | ')
  end
end
