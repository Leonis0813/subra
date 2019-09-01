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
|[:rvm][:requirements]    |Array[String]|required packages for rvm       |
|[:rvm][:install_dir]     |String       |install directory path          |
|[:rvm][:install_commands]|Array[String]|install commands for rvm package|

## Usage

### rvm

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
