# jenkins Cookbook

This cookbook install jenkins

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

|Key                                |Type         |Description                        |
|-----------------------------------|-------------|-----------------------------------|
|[:jenkins][:version]               |String       |installed jenkins version          |
|[:jenkins][:rpm_file]              |String       |download rpm file name             |
|[:jenkins][:rpm_path]              |String       |download rpm file path             |
|[:jenkins][:rpm_url]               |String       |download rpm url                   |
|[:jenkins][:host]                  |String       |jenkins server host                |
|[:jenkins][:cli_file]              |String       |download cli file name             |
|[:jenkins][:cli_path]              |String       |download cli file path             |
|[:jenkins][:cli_url]               |String       |download cli url                   |
|[:jenkins][:home]                  |String       |path to home directory of jenkins  |
|[:jenkins][:admin]][:username]     |String       |initial admin username             |
|[:jenkins][:admin]][:password_file]|String       |path to initial admin password file|
|[:jenkins][:tools_dir]             |String       |path to directory to put scripts   |
|[:jenkins][:accounts]              |Array[Hash]  |created accounts                   |
|[:jenkins][:plugins]               |Array[String]|installed plugin list              |
|[:jenkins][:deploy_jobs]           |Array[String]|created deploying job list         |
|[:jenkins][:other_jobs]            |Array[String]|created extra job list             |
|[:jenkins][:polling_jobs]          |Array[String]|created polling job list           |
|[:jenkins][:views]                 |Array[String]|created view list                  |
|[:jenkins][:github]                |Hash         |config for github operations       |

### jenkins::default

## Usage

### jenkins::default

Just include `jenkins` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[jenkins]"
  ]
}
```

## License and Authors

Authors: Leonis0813
