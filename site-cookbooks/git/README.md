# git Cookbook

This cookbook install git

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### git::default

|Key                      |Type         |Description                       |
|-------------------------|-------------|----------------------------------|
|[:git][:requirements]    |Array[String]|prerequirements for installing git|
|[:git][:version]         |String       |installed git version             |
|[:git][:download]        |Hash         |settings for downloading          |
|[:git][:install_dir]     |String       |install directory                 |
|[:git][:install_commands]|Array[String]|commands for install              |

## Usage

### git::default

Just include `git` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[git]"
  ]
}
```

## License and Authors

Authors: Leonis0813
