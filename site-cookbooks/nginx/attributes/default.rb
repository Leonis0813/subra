default[:nginx][:requirements] = %w[ pcre pcre-devel ]
default[:nginx][:version] = '1.10.2'
default[:nginx][:user] = 'nginx'
default[:nginx][:download] = {
  :url => "https://nginx.org/download/nginx-#{default[:nginx][:version]}.tar.gz",
  :dir => '/tmp',
  :file => "nginx-#{default[:nginx][:version]}.tar.gz",
}
default[:nginx][:install_dir] = '/opt/nginx'
default[:nginx][:apps] = []
default[:nginx][:conf_files] = []
