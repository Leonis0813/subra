# nginx Cookbook

This cookbook install nginx

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### nginx::default

|Key                       |Type         |Description                         |
|--------------------------|-------------|------------------------------------|
|[:nginx][:requirements]   |Array[String]|prerequirements for installing nginx|
|[:nginx][:version]        |String       |installed nginx version             |
|[:nginx][:user]           |String       |nginx user                          |
|[:nginx][:download][:url] |String       |url for nginx package               |
|[:nginx][:download][:dir] |String       |directory downloaded nginx package  |
|[:nginx][:download][:file]|String       |file name downloaded nginx package  |
|[:nginx][:install_dir]    |String       |install directory                   |
|[:nginx][:apps]           |Array[String]|web app names                       |
|[:nginx][:conf_files]     |Array[String]|config files placed on conf.d       |

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
