# rvm Cookbook

This cookbook install latest rvm.

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### rvm::default

|Key                 |Type  |Description           |Default           |
|--------------------|------|----------------------|------------------|
|[:gpg][:server]     |String|key server for gpg key|hkp://keys.gnupg  |
|[:rvm][:server]     |String|rvm server URI        |https://get.rvm.io|
|[:rvm][:install_dir]|String|install directory path|/usr/local/rvm    |

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
