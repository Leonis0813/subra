# regulus Cookbook

This cookbook deploy regulus

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### regulus::default

## Usage

### regulus::deploy

Just include `regulus` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[regulus::deploy]"
  ]
}
```

## License and Authors

Authors: Leonis0813
