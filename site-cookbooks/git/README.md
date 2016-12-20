# git Cookbook

This cookbook install git

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

#### git::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['git']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### git::install

Just include `git` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[git::install]"
  ]
}
```

## License and Authors

Authors: Leonis0813
