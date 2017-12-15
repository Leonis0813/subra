# redis Cookbook

This cookbook install latest redis

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### redis::default

|Key                     |Type  |Description            |
|------------------------|------|-----------------------|
|[:mysql][:root_password]|String|root password for mysql|

## Usage

### redis::install

Just include `redis` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[redis::install]"
  ]
}
```

## License and Authors

Authors: Leonis0813
