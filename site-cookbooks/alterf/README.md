# alterf Cookbook

This cookbook deploy alterf

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### alterf::default

## Usage

### alterf::deploy

Just include `rvm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[alterf::deploy]"
  ]
}
```

## License and Authors

Authors: Leonis0813
