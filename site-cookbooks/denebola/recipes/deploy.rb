#
# Cookbook Name:: denebola
# Recipe:: deploy
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
node[:denebola][:requirements].each do |package_name|
  package package_name
end

deploy node[:denebola][:deploy_dir] do
  repo node[:denebola][:repository]
  branch ENV['DENEBOLA_VERSION'] || node[:denebola][:branch]
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlink_before_migrate.clear
  symlinks node[:denebola][:symlinks]

  before_migrate do
    directory File.join(release_path, 'vendor')

    node[:denebola][:shared_dirs].each do |dir|
      directory File.join(node[:denebola][:deploy_dir], "shared/#{dir}") do
        recursive true
      end
    end

    link File.join(release_path, 'vendor/bundle') do
      to File.join(node[:denebola][:deploy_dir], 'shared/bundle')
    end

    execute 'rvm 2.2.0 do bundle install --path=vendor/bundle' do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end
  end
end
