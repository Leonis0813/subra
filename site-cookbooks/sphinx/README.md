# sphinx Cookbook

This cookbook install sphinx

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### sphinx::default

|Key                     |Type         |Description                          |
|------------------------|-------------|-------------------------------------|
|[:sphinx][:requirements]|Array[String]|prerequirements for installing sphinx|
|[:sphinx][:packages]    |Array[String]|pip packages for sphinx              |

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
