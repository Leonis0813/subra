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

package %w[devtoolset-1.1-gcc devtoolset-1.1-gcc-c++ devtoolset-1.1-gcc-gfortran] do
  options '--enablerepo=testing-1.1-devtools-6'
end

{
  'stringi' => '1.1.7',
  'RcppArmadillo' => '0.6.600.4.0',
  'stringr' => '1.3.0',
  'reshape2' => '1.4.2',
  'ggplot2' => '2.2.0',
  'forecast' => '8.2',
}.each do |package_name, version|
  remote_file "/tmp/#{package_name}.tar.gz" do
    source "https://cran.r-project.org/src/contrib/Archive/#{package_name}/#{package_name}_#{version}.tar.gz"
    owner 'root'
    group 'root'
    mode 0755
    not_if { File.exists?("/tmp/#{package_name}.tar.gz") }
  end

  bash "install #{package_name}" do
    cwd File.absolute_path(File.dirname(__FILE__) + '/../files/default')
    user 'root'
    group 'root'
    code <<"EOH"
sudo chmod 755 package.sh
./package.sh #{package_name}.tar.gz
if [ $? = 0 ]; then
  exit 1
else
  exit 1
fi
EOH
    environment 'CC' => '/opt/centos/devtoolset-1.1/root/usr/bin/gcc',
                'CXX' => '/opt/centos/devtoolset-1.1/root/usr/bin/g++',
                'PATH' => '/opt/centos/devtoolset-1.1/root/usr/bin:/usr/bin:/bin'
  end
end
