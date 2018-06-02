#
# Cookbook Name:: rstudio
# Recipe:: package
#
# Copyright 2016, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
remote_file '/etc/yum.repos.d/devtools-1.1.repo' do
  source 'http://people.centos.org/tru/devtools-1.1/devtools-1.1.repo'
  owner 'root'
  group 'root'
  mode 0755
  not_if { File.exists?('/tmp/rstudio-server-rhel-1.1.453-x86_64.rpm') }
end

package %w[devtoolset-1.1-gcc devtoolset-1.1-gcc-c++] do
  options '--enablerepo=testing-1.1-devtools-6'
end

{
  'RcppArmadillo' => '0.6.600.4.0',
  'stringi' => '1.1.7',
}.each do |package_name, version|
  remote_file "/tmp/#{package_name}.tar.gz" do
    source "https://cran.r-project.org/src/contrib/Archive/#{package_name}/#{package_name}_#{version}.tar.gz"
    owner 'root'
    group 'root'
    mode 0755
    not_if { File.exists?("/tmp/#{package_name}.tar.gz") }
  end

  script = File.absolute_path(File.dirname(__FILE__) + '/../files/default/package.r')
  execute "Rscript #{script} #{package_name}.tar.gz" do
    environment {
      'CC' => '/opt/centos/devtoolset-1.1/root/usr/bin/gcc',
      'CXX' => '/opt/centos/devtoolset-1.1/root/usr/bin/g++',
      'PATH' => '/opt/centos/devtoolset-1.1/root/usr/bin:$PATH',
    }
  end
end
