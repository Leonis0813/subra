# nfs Cookbook

This cookbook install nfs

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

#### nfs::default

|Key                       |Type         |Description                         |
|--------------------------|-------------|------------------------------------|

## Usage

### nfs::install

Just include `nfs` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nfs::install]"
  ]
}
```

## License and Authors

Authors: Leonis0813
