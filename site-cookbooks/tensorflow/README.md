# tensorflow Cookbook

This cookbook install tensorflow

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### tensorflow::default

|Key                         |Type  |Description                              |
|----------------------------|------|-----------------------------------------|
|[:tensorflow][:url]         |String|download url                             |
|[:tensorflow][:requirements]|Hash  |prerequirements for installing tensorflow|
|[:tensorflow][:pyenv]       |Hash  |pyenv settings                           |
|[:tensorflow][:python]      |String|python settings                          |

## Usage

### tensorflow

Just include `tensorflow` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[tensorflow]"
  ]
}
```

## License and Authors

Authors: Leonis0813
