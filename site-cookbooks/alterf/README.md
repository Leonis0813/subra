# alterf Cookbook

This cookbook deploy alterf

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### alterf::default

|Key                     |Type         |Description                  |
|------------------------|-------------|-----------------------------|
|[:alterf][:app_name]    |String       |application name             |
|[:alterf][:deploy_dir]  |String       |absolute path to deploy      |
|[:alterf][:repository]  |String       |github url for clone         |
|[:alterf][:branch]      |String       |deployed github branch       |
|[:alterf][:symlinks]    |Hash         |created symbolic links       |
|[:alterf][:shared_dirs] |Array[String]|directories created in shared|
|[:alterf][:requirements]|Array[String]|packages before deploying    |
|[:alterf][:ruby_version]|String       |ruby version for alterf      |
|[:alterf][:mysql_users] |Array[String]|users used by alterf         |
|[:alterf][:node]        |Hash         |node.js settings             |
|[:alterf][:python]      |Hash         |python settings              |
|[:alterf][:geckodriver] |Hash         |geckodriver settings         |

## Usage

### alterf::deploy

Just include `rvm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[alterf]"
  ]
}
```

## License and Authors

Authors: Leonis0813
