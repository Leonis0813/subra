# mysql Cookbook

This cookbook install latest mysql

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### mysql::default

|Key                     |Type         |Description                 |
|------------------------|-------------|----------------------------|
|[:mysql][:requirements] |Array[String]|prerequirement package names|
|[:mysql][:repository]   |Hash         |repository info             |
|[:mysql][:root_password]|String       |root password for mysql     |

## Usage

### mysql::install

Just include `mysql` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mysql::install]"
  ]
}
```

## License and Authors

Authors: Leonis0813
