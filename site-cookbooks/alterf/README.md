# alterf Cookbook

This cookbook deploy alterf

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### alterf::default

|Key                       |Type         |Description                  |
|--------------------------|-------------|-----------------------------|
|[:alterf][:app_name]      |String       |application name             |
|[:alterf][:deploy_dir]    |String       |absolute path to deploy      |
|[:alterf][:repository]    |String       |github url for clone         |
|[:alterf][:branch]        |String       |deployed github branch       |
|[:alterf][:symlinks]      |Hash         |created symbolic links       |
|[:alterf][:shared_dirs]   |Array[String]|directories created in shared|
|[:alterf][:ruby_version]  |String       |ruby version for alterf      |
|[:alterf][:mount_settings]|Array[Hash]  |mount settings for backup    |
|[:alterf][:export_dir]    |String       |directory path to export     |
|[:alterf][:exports]       |Array[Hash]  |export settings fot nfs      |

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
