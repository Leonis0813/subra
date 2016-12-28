# alterf Cookbook

This cookbook deploy alterf

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### alterf::default

|Key                      |Type         |Description                  |
|-------------------------|-------------|-----------------------------|
|[:alterf][:app_name]     |String       |application name             |
|[:alterf][:deploy_dir]   |String       |absolute path to deploy      |
|[:alterf][:repository]   |String       |github url for clone         |
|[:alterf][:cron_settings]|Array[Hash]  |settings for cron            |
|[:alterf][:cron_paths]   |Array[String]|environment variable for PATH|

## Usage

### alterf::deploy

Just include `rvm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[alterf::deploy]"
  ]
}
```

## License and Authors

Authors: Leonis0813
