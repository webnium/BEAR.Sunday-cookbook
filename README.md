BEAR.Sunday Cookbook
=============
This cookbook installs and maintain BEAR.Sunday and its application.

Requirements
------------

#### Cookbooks
- `yum` - install php >= 5.4
- `php` - install php
- `php-fpm` - install php-fpm used by `bear-sunday::nginx`
- `nginx` - for application server
- `composer` - BEAR.Sunday uses composer to manage dependency

Attributes
----------
#### bear-sunday::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['bear-sunday']['version']</tt></td>
    <td>String</td>
    <td>version to be installed</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['bear-sunday']['install_path']</tt></td>
    <td>String</td>
    <td>location where BEAR.Package to be placed</td>
    <td><tt>/usr/local/lib/bear</tt></td>
  </tr>
</table>

#### bear-sunday::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['bear-sunday']['app_name']</tt></td>
    <td>String</td>
    <td>Application name to be setup</td>
    <td><tt>"Sandbox"</tt></td>
  </tr>
  <tr>
    <td><tt>['bear-sunday']['nginx_context']</tt></td>
    <td>String "dev", "api" or "prod"</td>
    <td>context name to be run</td>
    <td><tt>"dev"</tt></td>
  </tr>
</table>


Usage
-----
#### bear-sunday::default
Just include `bear-sunday` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[bear-sunday]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Webnium, Inc
License: BSD
