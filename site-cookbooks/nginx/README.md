# nginx Cookbook

This cookbook install nginx

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### nginx::default

|Key                         |Type          |Description                         |
|----------------------------|--------------|------------------------------------|
|[:nginx][:requirements]     |Array[String] |prerequirements for installing nginx|
|[:nginx][:version]          |String        |installed nginx version             |
|[:nginx][:user]             |String        |nginx user                          |
|[:nginx][:download]         |Object        |settings to install nginx           |
|[:nginx][:install_dir]      |String        |install directory                   |
|[:nginx][:apps]             |Array[String] |web app names                       |
|[:nginx][:conf_files]       |Array[String] |config files placed on conf.d       |
|[:nginx][:html_files]       |Array[String] |html files placed on html           |
|[:nginx][:lua_files]        |Array[String] |lua files placed on lua             |
|[:nginx][:luajit]           |Object        |settings to install luajit          |
|[:nginx][:nginx_devel_kit]  |Object        |settings to install nginx_devel_kit |
|[:nginx][:lua_nginx_module] |Object        |settings to install lua_nginx_module|
|[:nginx][:lua_resty_mysql]  |Object        |settings to install lua_resty_mysql |
|[:nginx][:bootstrap]        |Object        |settings to download bootstrap      |

## Usage

### nginx::default

Just include `nginx` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nginx]"
  ]
}
```

## License and Authors

Authors: Leonis0813
