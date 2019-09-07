# zsh Cookbook

This cookbook install zsh

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### zsh::default

## Usage

### zsh::default

Just include `zsh` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[zsh]"
  ]
}
```

## License and Authors

Authors: Leonis0813
