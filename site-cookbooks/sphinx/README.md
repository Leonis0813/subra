# sphinx Cookbook

This cookbook install sphinx

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### sphinx::default

## Usage

### sphinx::install

Just include `sphinx` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sphinx::install]"
  ]
}
```

## License and Authors

Authors: Leonis0813
