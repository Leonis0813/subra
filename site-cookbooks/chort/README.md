# chort Cookbook

This cookbook deploy chort

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### chort::default

|Key                    |Type         |Description             |
|-----------------------|-------------|------------------------|
|[:chort][:app_name]    |String       |application name        |
|[:chort][:deploy_dir]  |String       |absolute path to deploy |
|[:chort][:repository]  |String       |github url for clone    |
|[:chort][:branch]      |String       |deployed github branch  |
|[:chort][:ruby_version]|String       |ruby version for danger |

## Usage

### chort::default

Just include `rvm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chort]"
  ]
}
```

## License and Authors

Authors: Leonis0813
