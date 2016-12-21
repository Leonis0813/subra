# emacs Cookbook

This cookbook install emacs

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### emacs::default

## Usage

### emacs::install

Just include `emacs` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[emacs::install]"
  ]
}
```

## License and Authors

Authors: Leonis0813
