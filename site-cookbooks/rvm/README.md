# rvm Cookbook

This cookbook install latest rvm.

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### rvm::default

|Key                      |Type         |Description                     |
|-------------------------|-------------|--------------------------------|
|[:gpg][:server]          |String       |key server for gpg key          |
|[:rvm][:server]          |String       |rvm server URI                  |
|[:rvm][:install_dir]     |String       |install directory path          |
|[:rvm][:path]            |String       |environment variable            |
|[:rvm][:install_commands]|Array[String]|install commands for rvm package|

## Usage

### rvm::install

Just include `rvm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[rvm]"
  ]
}
```

## License and Authors

Authors: Leonis0813
