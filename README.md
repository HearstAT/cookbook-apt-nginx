apt-nginx Cookbook
====================
[![Build Status](https://travis-ci.org/st-isidore-de-seville/cookbook-apt-nginx.svg?branch=master)](https://travis-ci.org/st-isidore-de-seville/cookbook-apt-nginx)
[![Chef Cookbook](https://img.shields.io/cookbook/v/apt-nginx.svg)](https://supermarket.chef.io/cookbooks/apt-nginx)

Installs/Configures apt NGINX Vendor-Specific Repositories.

This cookbook installs & configures apt NGINX repositories per
http://nginx.org/en/linux_packages.html.

Requirements
------------
- Chef 11 or higher
- Ruby 1.9 or higher (preferably from the Chef full-stack installer)
- Network accessible package repositories
- [apt Cookbook](https://supermarket.chef.io/cookbooks/apt)

Attributes
----------
#### apt-nginx::default
The default recipe is for installing & configuring the apt NGINX repostories.
Any attribute supported by the [apt cookbook](https://github.com/opscode-cookbooks/apt#attribute-parameters)
is supported by this cookbook and can be used to override attributes in this
cookbook.

Per http://wiki.nginx.org/Install, there are currently two versions of NGINX.
The mainline branch gets new features and bugfixes sooner but might introduce
new bugs as well.  Critical bugfixes are backported to the stable branch.  In
general, the stable release is recommended, but the mainline release is
typically quite stable as well.

- `['apt-nginx']['debian']['supported-codenames']`
  - _Type:_ Hash

  - _Description:_

    Debian-ish platform support for this cookbook and the NGINX repository.
    Designed to be a private attribute however it can be overridden in the case
    NGINX supports additional platforms and this cookbook has not been updated
    yet.

    This check was implemented as a result of the repo could be successfully
    installed yet not be valid for a given platform and an NGINX package could
    be successfully installed as a result of it being available natively on the
    platform it which it was run which results in a false positive for the
    consumer of the cookbook.

    The hash key is the codename of the OS/version.  If the hash value evaluates
    to true, the OS/version is considered supported.

  - _Default:_

    ```ruby
    {
      squeeze: true,  # Debian 6.x
      wheezy:  true,  # Debian 7.x
      jessie:  true,  # Debian 8.x
      lucid:   true,  # Ubuntu 10.04
      precise: true,  # Ubuntu 12.04
      trusty:  true,  # Ubuntu 14.04
      utopic:  true   # Ubuntu 14.10
    }
    ```
- NGINX Stable Repo
  - `['apt-nginx']['repos']['nginx-stable']['managed']`
    - _Type:_ Boolean
    - _Description:_ Does this cookbook manage the install of the NGINX Stable
      Repo?
    - _Default:_ `true`
  - `['apt-nginx']['repos']['nginx-stable']['uri']`
    - _Type:_ String
    - _Description:_ URI of NGINX Stable Repo
    - _Default:_ `http://nginx.org/packages/#{node['platform']}`
  - `['apt-nginx']['repos']['nginx-stable']['distribution']`
    - _Type:_ String
    - _Description:_ Package distribution of NGINX Stable Repo
    - _Default:_ `node['lsb']['codename']`
  - `['apt-nginx']['repos']['nginx-stable']['components']`
    - _Type:_ Array
    - _Description:_ NGINX Stable Repo Package Groupings
    - _Default:_ `['nginx']`
  - `['apt-nginx']['repos']['nginx-stable']['key']`
    - _Type:_ String
    - _Description:_ Cookbook File for NGINX Stable Repo Signing Key
    - _Default:_ `nginx_signing.key`
  - `['apt-nginx']['repos']['nginx-stable']['deb-src']`
    - _Type:_ Boolean
    - _Description:_ Whether or not to include the NGINX Stable Source Repo?
    - _Default:_ `false`
- NGINX Mainline Repo
  - `['apt-nginx']['repos']['nginx-mainline']['managed']`
    - _Type:_ Boolean
    - _Description:_ Does this cookbook manage the install of the NGINX Mainline
      Repo?
    - _Default:_ `false`
  - `['apt-nginx']['repos']['nginx-mainline']['uri']`
    - _Type:_ String
    - _Description:_ URI of NGINX Mainline Repo
    - `http://nginx.org/packages/mainline/#{node['platform']}`
  - `['apt-nginx']['repos']['nginx-mainline']['distribution']`
    - _Type:_ String
    - _Description:_ Package distribution of NGINX Mainline Repo
    - _Default:_ `node['lsb']['codename']`
  - `['apt-nginx']['repos']['nginx-mainline']['components']`
    - _Type:_ Array
    - _Description:_ NGINX Mainline Repo Package Groupings
    - _Default:_ `['nginx']`
  - `['apt-nginx']['repos']['nginx-mainline']['key']`
    - _Type:_ String
    - _Description:_ Cookbook File for NGINX Mainline Repo Signing Key
    - _Default:_ `nginx_signing.key`
  - `['apt-nginx']['repos']['nginx-mainline']['deb-src']`
    - _Type:_ Boolean
    - _Description:_ Whether or not to include the NGINX Mainline Source Repo?
    - _Default:_ `false`

Usage
-----
#### apt-nginx::default
Just include `apt-nginx` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[apt-repo]"
  ]
}
```

Contributing
------------
1. Fork the repository on GitHub
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using GitHub

Development Environment
-------------------
This repository contains a Vagrantfile which can be used to spin up a
fully configured development environment in Vagrant.  

Vagrant requires the following:
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

The Vagrant environment for this repository is based on:
- [st-isidore-de-seville/trusty64-rvm-docker](https://atlas.hashicorp.com/st-isidore-de-seville/boxes/trusty64-rvm-docker)

The Vagrant environment will initialize itself to:
- install required Ruby gems
- run integration testing via kitchen-docker when calling `kitchen`

The Vagrant environment can be spun up by performing the following commands:

1. `vagrant up`
2. `vagrant ssh`
3. `cd /vagrant`

Authors
-------------------
- Author:: St. Isidore de Seville (st.isidore.de.seville@gmail.com)

License
-------------------
```text
The MIT License (MIT)

Copyright (c) 2015 St. Isidore de Seville (st.isidore.de.seville@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
