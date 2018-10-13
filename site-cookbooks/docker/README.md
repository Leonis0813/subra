# docker Cookbook

This cookbook install docker

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### docker::default

|Key                         |Type  |Description                              |
|----------------------------|------|-----------------------------------------|

## Usage

### docker

Just include `docker` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[docker]"
  ]
}
```

## License and Authors

Authors: Leonis0813
