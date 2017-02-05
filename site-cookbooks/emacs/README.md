# emacs Cookbook

This cookbook install emacs

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### emacs::default

|Key                       |Type         |Description                         |
|--------------------------|-------------|------------------------------------|
|[:emacs][:requirements]   |Array[String]|prerequirements for installing emacs|
|[:emacs][:version]        |String       |installed emacs version             |
|[:emacs][:download][:url] |String       |url for emacs package               |
|[:emacs][:download][:dir] |String       |directory downloaded emacs package  |
|[:emacs][:download][:file]|String       |file name downloaded emacs package  |

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
