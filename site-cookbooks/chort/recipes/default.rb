#
# Cookbook Name:: chort
# Recipe:: default
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
pyenv_root = node[:sphinx][:pyenv][:root]
python_version = node[:sphinx][:python][:version]

deploy node[:chort][:deploy_dir] do
  repo node[:chort][:repository]
  branch ENV['CHORT_VERSION'] || node[:chort][:branch]
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks.clear

  before_symlink do
    execute "pyenv global #{python_version} && pyenv rehash && make html" do
      cwd release_path
      environment 'PYENV_ROOT' => pyenv_root,
                  'PATH' => "#{pyenv_root}/versions/#{python_version}/bin:#{pyenv_root}/bin:/usr/bin:/bin"
    end
  end

  after_restart do
    symlink = "#{node[:nginx][:install_dir]}/html/docs"

    directory symlink do
      recursive true
      not_if { File.exist?(symlink) }
    end

    link symlink do
      to File.join(node[:chort][:deploy_dir], 'current/_build/html')
    end
  end
end
