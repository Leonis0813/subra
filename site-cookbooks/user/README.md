# user Cookbook

This cookbook operate user.

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### user::create

|Key               |Type  |Description            |
|------------------|------|-----------------------|
|[:user][:name]    |String|user name              |
|[:user][:home]    |String|home directory of user |
|[:user][:password]|String|hashed password of user|

## Usage

### user::create

Just include `user` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[user::create]"
  ]
}
```

## License and Authors

Authors: Leonis0813
