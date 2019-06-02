#
# Cookbook Name:: zosma
# Recipe:: app
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
rvm_do = "rvm #{node[:zosma][:ruby_version]} do"

deploy node[:zosma][:deploy_dir] do
  repo node[:zosma][:repository]
  branch ENV['ZOSMA_VERSION'] || node[:zosma][:branch]
  symlink_before_migrate.clear
  create_dirs_before_symlink.clear
  purge_before_symlink.clear
  symlinks node[:zosma][:symlinks]
  migrate true
  migration_command "#{rvm_do} bundle exec rake db:migrate"
  environment 'RAILS_ENV' => node.chef_environment, 'PATH' => node[:rvm][:path]

  before_migrate do
    directory File.join(release_path, 'vendor')

    node[:zosma][:shared_dirs].each do |dir|
      directory File.join(node[:zosma][:deploy_dir], "shared/#{dir}") do
        recursive true
      end
    end

    [%w[log log], %w[vendor/bundle bundle]].each do |from, to|
      link File.join(release_path, from) do
        to File.join(release_path, "../../shared/#{to}")
      end
    end

    execute "#{rvm_do} bundle install --path=vendor/bundle --clean" do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end

    execute "#{rvm_do} bundle exec rake db:create" do
      cwd release_path
      environment 'PATH' => node[:rvm][:path]
    end
  end
end
