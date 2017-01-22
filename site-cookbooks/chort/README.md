# chort Cookbook

This cookbook build docs

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### chort::default

## Usage

### chort::default

Just include `chort` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chort::build]"
  ]
}
```

## License and Authors

Authors: Leonis0813
