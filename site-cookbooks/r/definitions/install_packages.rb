define :install_packages, package: {} do
  remote_file "/etc/yum.repos.d/#{node[:rstudio][:devtools_file]}" do
    source "http://people.centos.org/tru/devtools-1.1/#{node[:rstudio][:devtools_file]}"
    owner 'root'
    group 'root'
    mode '0755'
    not_if { File.exists?("/etc/yum.repos.d/#{node[:rstudio][:devtools_file]}") }
  end

  package %w[devtoolset-1.1-gcc devtoolset-1.1-gcc-c++ devtoolset-1.1-gcc-gfortran] do
    options '--enablerepo=testing-1.1-devtools-6'
  end

  params[:package].each do |package_name, version|
    remote_file "/tmp/#{package_name}.tar.gz" do
      source "https://cran.r-project.org/src/contrib/Archive/#{package_name}/#{package_name}_#{version}.tar.gz"
      owner 'root'
      group 'root'
      mode '0755'
      not_if { File.exists?("/tmp/#{package_name}.tar.gz") }
    end

    bash "install #{package_name} #{version}" do
      cwd File.absolute_path(File.dirname(__FILE__) + '/../files/default')
      user 'root'
      group 'root'
      code <<"EOF"
sudo chmod 755 package.sh
./package.sh #{package_name}.tar.gz
if [ -e /usr/lib64/R/library/#{package_name}/R/#{package_name} ]; then
  exit 0
else
  exit 1
fi
EOF
      environment 'CC' => '/opt/centos/devtoolset-1.1/root/usr/bin/gcc',
                  'CXX' => '/opt/centos/devtoolset-1.1/root/usr/bin/g++',
                  'PATH' => '/opt/centos/devtoolset-1.1/root/usr/bin:/usr/bin:/bin'
      not_if { File.exists?("/usr/lib64/R/library/#{package_name}/R/#{package_name}") }
    end
  end
end
