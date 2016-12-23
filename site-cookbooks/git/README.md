# git Cookbook

This cookbook install git

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### git::default

|Key                  |Type         |Description                       |
|---------------------|-------------|----------------------------------|
|[:git][:requirements]|Array[String]|prerequirements for installing git|
|[:git][:version]     |String       |installed git version             |
|[:git][:install_dir] |String       |install directory                 |

## Usage

### git::install

Just include `git` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[git::install]"
  ]
}
```

## License and Authors

Authors: Leonis0813
