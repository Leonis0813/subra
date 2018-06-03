# r Cookbook

This cookbook install latest r

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Usage

### r::default

Just include `r` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[r]"
  ]
}
```

## License and Authors

Authors: Leonis0813
