# pyenv Cookbook

This cookbook install latest pyenv.

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### pyenv::default

|Key                  |Type  |Description                  |
|---------------------|------|-----------------------------|
|[:pyenv][:root]      |String|root directory path for pyenv|
|[:pyenv][:repository]|String|pyenv git reposiroty         |
|[:pyenv][:revision]  |String|pyenv clone version          |
|[:pyenv][:virtualenv]|Hash  |virtualenv plugin settings   |

## Usage

### pyenv

Just include `pyenv` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[pyenv]"
  ]
}
```

## License and Authors

Authors: Leonis0813
