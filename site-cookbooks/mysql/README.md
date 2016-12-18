# mysql Cookbook

This cookbook install latest mysql

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Usage

### mysql::install

Just include `mysql` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mysql::install]"
  ]
}
```

## License and Authors

Authors: Leonis0813
