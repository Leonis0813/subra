# regulus Cookbook

This cookbook deploy regulus

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### regulus::default

|Key                               |Type         |Description                   |
|----------------------------------|-------------|------------------------------|
|[:regulus][:app_name]             |String       |application name              |
|[:regulus][:deploy_dir]           |String       |absolute path to deploy       |
|[:regulus][:repository]           |String       |github url for clone          |
|[:regulus][:branch]               |String       |deployed github branch        |
|[:regulus][:symlinks]             |Hash         |created symbolic links        |
|[:regulus][:shared_dirs]          |Array[String]|directories created in shared |
|[:regulus][:requirements]         |Array[String]|required packages for regulus |
|[:regulus][:username]             |String       |regulus manager name          |
|[:regulus][:password]             |String       |user password                 |
|[:regulus][:smb][:packages]       |Array[String]|samba packages                |
|[:regulus][:smb][:share_name]     |String       |shared directory path         |
|[:regulus][:smb][:mount_dir]      |String       |mount directory path          |
|[:regulus][:smb][:credential_file]|String       |credential file path for mount|
|[:regulus][:cron_settings]        |Array[Hash]  |settings for cron             |
|[:regulus][:cron_paths]           |Array[String]|environment variable for PATH |
|[:regulus][:ruby_version]         |String       |ruby version for regulus      |
|[:regulus][:mount_settings]       |Array[Hash]  |mount settings for backup     |
|[:regulus][:export_dir]           |String       |directory path to export      |
|[:regulus][:exports]              |Array[Hash]  |export settings fot nfs       |

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
