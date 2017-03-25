# nfs Cookbook

This cookbook install nfs

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

#### nfs::default

|Key                      |Type         |Description                    |
|-------------------------|-------------|-------------------------------|
|[:nfs][:services]        |Array[String]|required packages for nfs mount|
|[:nfs][:iptables_path]   |String       |path to iptables               |
|[:nfs][:iptable_settings]|Array[Hash]  |open ports for nfs             |

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
