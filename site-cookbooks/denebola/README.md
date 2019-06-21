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
|[:denebola][:requirements]  |Array[String]|packages before deploying    |
|[:denebola][:ruby_version]  |String       |ruby version for denebola    |
|[:denebola][:export_dir]    |String       |directory path to export     |
|[:denebola][:exports]       |Array[Hash]  |export settings fot nfs      |
|[:denebola][:log_level]     |String       |log level for mysql inquiry  |
|[:denebola][:database]      |Array[Object]|database settings per env    |

## Usage

### denebola

Just include `rvm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[denebola]"
  ]
}
```

## License and Authors

Authors: Leonis0813
