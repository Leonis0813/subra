# zosma Cookbook

This cookbook deploy zosma

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### zosma::default

|Key                     |Type         |Description                   |
|------------------------|-------------|------------------------------|
|[:zosma][:app_name]     |String       |application name              |
|[:zosma][:deploy_dir]   |String       |absolute path to deploy       |
|[:zosma][:repository]   |String       |github url for clone          |
|[:zosma][:branch]       |String       |deployed github branch        |
|[:zosma][:symlinks]     |Hash         |created symbolic links        |
|[:zosma][:shared_dirs]  |Array[String]|directories created in shared |
|[:zosma][:requirements] |Array[String]|required packages for zosma   |
|[:zosma][:username]     |String       |zosma manager name            |
|[:zosma][:smb]          |Hash         |samba packages                |
|[:zosma][:ruby_version] |String       |ruby version for zosma        |
|[:zosma][:log_level]    |String       |log level for mysql inquiry   |

## Usage

### zosma

Just include `zosma` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[zosma]"
  ]
}
```

## License and Authors

Authors: Leonis0813
