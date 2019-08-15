# regulus Cookbook

This cookbook deploy regulus

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### regulus::default

|Key                               |Type         |Description                   |
|----------------------------------|-------------|------------------------------|
|[:regulus][:app_name]             |String       |application name              |
|[:regulus][:deploy_dir]           |String       |absolute path to deploy       |
|[:regulus][:repository]           |String       |github url for clone          |
|[:regulus][:branch]               |String       |deployed github branch        |
|[:regulus][:symlinks]             |Hash         |created symbolic links        |
|[:regulus][:shared_dirs]          |Array[String]|directories created in shared |
|[:regulus][:requirements]         |Array[String]|required packages for regulus |
|[:regulus][:ruby_version]         |String       |ruby version for regulus      |
|[:regulus][:open_ports]           |Array[String]|tcp ports used by regulus     |
|[:regulus][:mysql_users]          |Array[String]|users used by regulus         |
|[:regulus][:python_packages]      |Array[String]|required packages for scripts |

## Usage

### regulus::default

Just include `regulus` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[regulus]"
  ]
}
```

## License and Authors

Authors: Leonis0813
