# rstudio Cookbook

This cookbook install latest rstudio

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Usage

### rstudio::install

Just include `rstudio` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[rstudio]"
  ]
}
```

## License and Authors

Authors: Leonis0813
