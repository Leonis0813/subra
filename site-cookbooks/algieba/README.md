# algieba Cookbook

This cookbook deploy algieba

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### algieba::default

## Usage

### algieba::default

Just include `algieba` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[algieba::deploy]"
  ]
}
```

## License and Authors

Authors: Leonis0813
