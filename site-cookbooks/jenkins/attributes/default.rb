default[:jenkins][:version] = '2.40'
default[:jenkins][:rpm_file] = "jenkins-#{default[:jenkins][:version]}-1.1.noarch.rpm"
default[:jenkins][:rpm_path] = "/tmp/#{default[:jenkins][:rpm_file]}"
default[:jenkins][:rpm_url] = "http://pkg.jenkins-ci.org/redhat/#{default[:jenkins][:rpm_file]}"
default[:jenkins][:host] = 'http://localhost:8080/jenkins'
default[:jenkins][:cli_file] = 'jenkins-cli.jar'
default[:jenkins][:cli_path] = "/tmp/#{default[:jenkins][:cli_file]}"
default[:jenkins][:cli_url] = "#{default[:jenkins][:host]}/jnlpJars/#{default[:jenkins][:cli_file]}"
default[:jenkins][:admin][:username] = 'admin'
default[:jenkins][:admin][:password_file] = '/var/lib/jenkins/secrets/initialAdminPassword'
default[:jenkins][:accounts] = [{:id => 'leonis', :password => '7QiSlC?4'}]
default[:jenkins][:plugins] = %w[ git parameterized-trigger ansicolor ]
default[:jenkins][:jobs] = %w[
  alterf
  alterf-module_test
  alterf-function_test
  alterf-deploy
  alterf-import
  alterf-aggregate
  regulus
  regulus-module_test
  regulus-function_test
  regulus-deploy
  regulus-aggregate
  regulus-compress
  algieba
  algieba-module_test
  algieba-function_test
  algieba-deploy
  algieba-system_test
  chort
]
default[:jenkins][:views] = %w[ algieba alterf regulus ]
