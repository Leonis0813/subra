# rvm Cookbook

This cookbook install latest rvm.

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### rvm::default

|Key            |Type  |Description           |Default                                 |
|---------------|------|----------------------|----------------------------------------|
|[:gpg][:server]|String|key server for gpg key|hkp://keys.gnupg                        |
|[:gpg][:key]   |String|recv key for gpg key  |409B6B1796C275462A1703113804BB82D39DC0E3|
|[:rvm][:server]|String|rvm server URI        |https://get.rvm.io                      |

## Usage

### rvm::default

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
