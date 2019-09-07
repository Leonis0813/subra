default[:mysql][:requirements] = %w[yum-utils]
default[:mysql][:repository] = {
  url: 'http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm',
  file_path: '/tmp/mysql57.rpm',
}
default[:mysql][:root_password] = '7QiSlC?4'
