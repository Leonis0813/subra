#
# Cookbook Name:: alterf
# Recipe:: deploy
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
deploy node[:alterf][:deploy_dir] do
  repo node[:alterf][:repository]
  branch 'develop'
  action :deploy
  migrate false
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlink_before_migrate.clear
  symlinks 'log' => 'log'

  before_migrate do
    directory File.join(release_path, '../../shared/log')
  end
end
