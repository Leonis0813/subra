default[:nginx][:requirements] = %w[ pcre pcre-devel lua-sql-mysql ]
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
default[:nginx][:html_files] = %w[login portal]
default[:nginx][:lua_files] = %w[login authenticate]
default[:nginx][:luajit][:version] = '2.0.5'
default[:nginx][:luajit][:src] = "LuaJIT-#{default[:nginx][:luajit][:version]}.tar.gz"
default[:nginx][:luajit][:download] = {
  :url => "http://luajit.org/download/#{default[:nginx][:luajit][:src]}",
  :dir => '/tmp',
}
default[:nginx][:luajit][:install_dir] = '/usr/local/luajit'
default[:nginx][:nginx_devel_kit][:version] = '0.3.0'
default[:nginx][:nginx_devel_kit][:src] = "v#{default[:nginx][:nginx_devel_kit][:version]}.tar.gz"
default[:nginx][:nginx_devel_kit][:download] = {
  :url => "https://github.com/simplresty/ngx_devel_kit/archive/#{default[:nginx][:nginx_devel_kit][:src]}",
  :dir => '/usr/local/src',
}
default[:nginx][:lua_nginx_module][:version] = '0.10.11'
default[:nginx][:lua_nginx_module][:src] = "v#{default[:nginx][:lua_nginx_module][:version]}.tar.gz"
default[:nginx][:lua_nginx_module][:download] = {
  :url => "https://github.com/openresty/lua-nginx-module/archive/#{default[:nginx][:lua_nginx_module][:src]}",
  :dir => '/usr/local/src',
}
default[:nginx][:lua_resty_mysql][:version] = '0.21'
default[:nginx][:lua_resty_mysql][:src] = "v#{default[:nginx][:lua_resty_mysql][:version]}.tar.gz"
default[:nginx][:lua_resty_mysql][:download] = {
  :url => "https://github.com/openresty/lua-resty-mysql/archive/#{default[:nginx][:lua_resty_mysql][:src]}",
  :dir => '/usr/local/src',
}
