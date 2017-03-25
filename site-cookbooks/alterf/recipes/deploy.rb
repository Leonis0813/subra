#
# Cookbook Name:: alterf
# Recipe:: deploy
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
node[:alterf][:requirements].each do |package_name|
  package package_name do
    action :install
  end
end

deploy node[:alterf][:deploy_dir] do
  repo node[:alterf][:repository]
  branch ENV['ALTERF_VERSION'] || node[:alterf][:branch]
  action :deploy
  migrate false
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlink_before_migrate.clear
  symlinks node[:alterf][:symlinks]

  before_migrate do
    directory File.join(release_path, 'vendor')

    node[:alterf][:shared_dirs].each do |dir|
      directory File.join(release_path, "../../shared/#{dir}") do
        recursive true
      end
    end

    link File.join(release_path, 'vendor/bundle') do
      to File.join(release_path, '../../shared/bundle')
      link_type :symbolic
    end

    execute 'rvm 2.2.0 do bundle install --path=vendor/bundle' do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
      not_if { node.chef_environment == 'compute' }
    end
  end
end
