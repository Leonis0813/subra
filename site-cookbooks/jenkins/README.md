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
|[:jenkins][:cli_file]              |String       |download cli file name             |
|[:jenkins][:cli_path]              |String       |download cli file path             |
|[:jenkins][:cli_url]               |String       |download cli url                   |
|[:jenkins][:admin]][:username]     |String       |initial admin username             |
|[:jenkins][:admin]][:password_file]|String       |path to initial admin password file|
|[:jenkins][:host]                  |String       |jenkins server host                |
|[:jenkins][:accounts]              |Array[Hash]  |created accounts                   |
|[:jenkins][:plugins]               |Array[String]|installed plugin list              |
|[:jenkins][:jobs]                  |Array[String]|created job list                   |

### jenkins::default

## Usage

### jenkins::install

Just include `jenkins` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[jenkins::install]"
  ]
}
```

## License and Authors

Authors: Leonis0813
