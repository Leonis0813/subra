default[:jenkins][:version] = '2.40'
default[:jenkins][:rpm_file] = "jenkins-#{default[:jenkins][:version]}-1.1.noarch.rpm"
default[:jenkins][:rpm_path] = "/tmp/#{default[:jenkins][:rpm_file]}"
default[:jenkins][:rpm_url] = "http://pkg.jenkins-ci.org/redhat/#{default[:jenkins][:rpm_file]}"
