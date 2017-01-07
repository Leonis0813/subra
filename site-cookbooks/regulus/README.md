# regulus Cookbook

This cookbook deploy regulus

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### regulus::default

|Key                          |Type         |Description                  |
|-----------------------------|-------------|-----------------------------|
|[:regulus][:app_name]        |String       |application name             |
|[:regulus][:deploy_dir]      |String       |absolute path to deploy      |
|[:regulus][:repository]      |String       |github url for clone         |
|[:regulus][:branch]          |String       |deployed github branch       |
|[:regulus][:username]        |String       |regulus manager name         |
|[:regulus][:password]        |String       |user password                |
|[:regulus][:smb][:share_name]|String       |shared directory path        |
|[:regulus][:smb][:mount_dir] |String       |mount directory path         |
|[:regulus][:cron_settings]   |Array[Hash]  |settings for cron            |
|[:regulus][:cron_paths]      |Array[String]|environment variable for PATH|
|[:regulus][:delete_old_files]|boolean      |whether delete old rate files|

## Usage

### regulus::deploy

Just include `regulus` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[regulus::deploy]"
  ]
}
```

## License and Authors

Authors: Leonis0813
