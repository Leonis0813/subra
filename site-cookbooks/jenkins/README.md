# jenkins Cookbook

This cookbook install jenkins

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

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
