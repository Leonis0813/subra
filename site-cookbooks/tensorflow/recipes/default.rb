#
# Cookbook Name:: tensorflow
# Recipe:: default
#
# Copyright 2018, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
pyenv = node[:tensorflow][:pyenv]
python = node[:tensorflow][:python]

git pyenv[:root] do
  repository pyenv[:repository]
  revision pyenv[:revision]
  not_if { File.exists?(pyenv[:root]) }
end

['init -', "install #{python[:version]}"].each do |command|
  execute "pyenv #{command}" do
    environment 'PYENV_ROOT' => pyenv[:root],
                'PATH' => "#{pyenv[:root]}/bin:/usr/bin:/bin"
    not_if { File.exists?("#{pyenv[:root]}/versions/#{python[:version]}") }
  end
end

execute "pyenv global #{python[:version]} && pip install #{node[:tensorflow][:url]}" do
  environment 'PYENV_ROOT' => pyenv[:root],
              'PATH' => "#{pyenv[:root]}/versions/#{python[:version]}/bin:#{pyenv[:root]}/bin:/usr/bin:/bin"
end

node[:tensorflow][:requirements][:packages].each do |package|
  file_path = "/tmp/#{package}"

  remote_file file_path do
    source "#{node[:tensorflow][:requirements][:base_url]}/#{package}"
    owner 'root'
    group 'root'
    mode '0755'
    not_if { File.exists?(file_path) }
  end

  package package do
    source file_path
  end
end
