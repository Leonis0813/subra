# nginx Cookbook

This cookbook install nginx

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### nginx::default

## Usage

### nginx::install

Just include `nginx` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nginx::install]"
  ]
}
```

## License and Authors

Authors: Leonis0813
