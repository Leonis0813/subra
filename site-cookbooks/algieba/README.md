# algieba Cookbook

This cookbook deploy algieba

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### algieba::default

|Key                      |Type         |Description                  |
|-------------------------|-------------|-----------------------------|
|[:algieba][:app_name]    |String       |application name             |
|[:algieba][:deploy_dir]  |String       |absolute path to deploy      |
|[:algieba][:repository]  |String       |github url for clone         |
|[:algieba][:branch]      |String       |deployed github branch       |
|[:algieba][:symlinks]    |Hash         |created symbolic links       |
|[:algieba][:shared_dirs] |Array[String]|directories created in shared|
|[:algieba][:ruby_version]|String       |ruby version for algieba     |
|[:algieba][:open_ports]  |Array[String]|tcp ports used by algieba    |
|[:algieba][:mysql_users] |Array[String]|mysql user names             |
|[:algieba][:requirements]|Array[String]|packages before deploying    |

## Usage

### algieba::default

Just include `algieba` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[algieba]"
  ]
}
```

## License and Authors

Authors: Leonis0813
