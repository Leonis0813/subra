#
# Cookbook Name:: chort
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
ruby_version = node[:chort][:ruby_version]

rvm_ruby ruby_version

rvm_gem 'bundler' do
  ruby_version ruby_version
  gemset 'global'
  gem_version '2.1.4'
  force true
end

deploy node[:chort][:deploy_dir] do
  repo node[:chort][:repository]
  branch ENV['CHORT_VERSION'] || node[:chort][:branch]
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks.clear

  before_symlink do
    python = node[:sphinx][:python]
    activate_command = [
      'eval "$(pyenv init -)"',
      'eval "$(pyenv virtualenv-init -)"',
      "pyenv activate #{python[:virtualenv]}",
    ].join(' && ')

    execute "#{activate_command} && make html" do
      cwd release_path
      environment 'PYENV_ROOT' => node[:pyenv][:root],
                  'PATH' => [
                    "#{node[:pyenv][:root]}/versions/#{python[:version]}/bin",
                    "#{node[:pyenv][:root]}/bin",
                    '/usr/bin',
                    '/bin',
                  ].join(':')
    end
  end

  after_restart do
    link "#{node[:nginx][:install_dir]}/html/docs" do
      to File.join(node[:chort][:deploy_dir], 'current/_build/html')
    end
  end
end
