# denebola Cookbook

This cookbook deploy denebola

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### denebola::default

|Key                         |Type         |Description                  |
|----------------------------|-------------|-----------------------------|
|[:denebola][:app_name]      |String       |application name             |
|[:denebola][:deploy_dir]    |String       |absolute path to deploy      |
|[:denebola][:repository]    |String       |github url for clone         |
|[:denebola][:branch]        |String       |deployed github branch       |
|[:denebola][:symlinks]      |Hash         |created symbolic links       |
|[:denebola][:shared_dirs]   |Array[String]|directories created in shared|
|[:denebola][:ruby_version]  |String       |ruby version for denebola      |
|[:denebola][:mount_settings]|Array[Hash]  |mount settings for backup    |
|[:denebola][:export_dir]    |String       |directory path to export     |
|[:denebola][:exports]       |Array[Hash]  |export settings fot nfs      |

## Usage

### denebola::deploy

Just include `rvm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[denebola::deploy]"
  ]
}
```

## License and Authors

Authors: Leonis0813
