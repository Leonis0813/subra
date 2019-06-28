default[:jenkins][:version] = '2.130'
default[:jenkins][:rpm_file] = "jenkins-#{default[:jenkins][:version]}-1.1.noarch.rpm"
default[:jenkins][:rpm_path] = "/tmp/#{default[:jenkins][:rpm_file]}"
default[:jenkins][:rpm_url] =
  "http://pkg.jenkins-ci.org/redhat/#{default[:jenkins][:rpm_file]}"
default[:jenkins][:host] = 'http://localhost:8080/jenkins'
default[:jenkins][:cli_file] = 'jenkins-cli.jar'
default[:jenkins][:cli_path] = "/tmp/#{default[:jenkins][:cli_file]}"
default[:jenkins][:cli_url] =
  "#{default[:jenkins][:host]}/jnlpJars/#{default[:jenkins][:cli_file]}"
default[:jenkins][:home] = '/var/lib/jenkins'
default[:jenkins][:admin][:username] = 'admin'
default[:jenkins][:admin][:password_file] =
  "#{default[:jenkins][:home]}/secrets/initialAdminPassword"
default[:jenkins][:tools_dir] = "#{default[:jenkins][:home]}/tools"
default[:jenkins][:accounts] = [{id: 'leonis', password: '7QiSlC?4'}]
default[:jenkins][:job][:check_pull_request] = []
default[:jenkins][:job][:denebola] = []
default[:jenkins][:job][:deploy] = []
default[:jenkins][:job][:other] = []
default[:jenkins][:job][:polling] = []
default[:jenkins][:job][:update_gems] = []
default[:jenkins][:job][:zosma] = []
default[:jenkins][:views] = []
default[:jenkins][:github] = {
  scripts: %w[create_pull_request.rb],
  update_gem_title: 'Update gems',
  update_gem_branch: 'update-gem',
}
