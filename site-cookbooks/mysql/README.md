# mysql Cookbook

This cookbook install latest mysql

## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### mysql::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mysql']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### mysql::default

Just include `mysql` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mysql]"
  ]
}
```

## License and Authors

Authors: TODO: List authors

