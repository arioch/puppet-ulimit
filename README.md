-*- mode: markdown; mode: visual-line;  -*-

# Ulimit Puppet Module

[![Puppet Forge](http://img.shields.io/puppetforge/v/svarrette/ulimit.svg)](https://forge.puppet.com/svarrette/ulimit) [![License](http://img.shields.io/:license-Apache2.0-blue.svg)](LICENSE) ![Supported Platforms](http://img.shields.io/badge/platform-debian|redhat|centos-lightgrey.svg)

      Copyright (c) 2015-2017 Tom De Vylder (aka arioch), Sebastien Varrette (aka Falkor)

[ulimit](https://ss64.com/bash/ulimit.html) provides control over the resources available to the shell and to processes started by it, on systems that allow such control.

This [Puppet](https://puppet.com/) module is designed to configure and manage ulimits on your Linux system, mainly with the `ulimit::rule` definition which permits to define soft  and/or hard limits over various domains.

* The soft limit is the value that the kernel enforces for the corresponding resource.
* The hard limit acts as a ceiling for the soft limit.


**`/! IMPORTANT`: This module is a fork from [arioch/puppet-ulimit](https://github.com/arioch/puppet-ulimit/)!!!**
This was done to allow a version release on my own namespace compliant with Puppet 4 until [Tom/arioch](https://github.com/arioch) released the official new version on his module.
In the mean time, I added more features (vagrant-based tests, support for arrays, content and source) yet **this module is expected to disappear** once [Tom/arioch](https://github.com/arioch) (hopefully) integrate my pull-request.

In particular, this module implements the following elements:

* class `ulimit`: The main class, piloting all aspects of the configuration
* class `ulimit::config`: an **internal** class taking care of global configurations and defaults
* definition `ulimit::rule`: permiting to define a rule in `'/etc/security/limits.d/'`

All these components are configured through a set of variables you will find in [`manifests/params.pp`](https://github.com/Falkor/puppet-ulimit/blob/master/manifests/params.pp).

### Setup Requirements

This module have been successfully over Puppet 4.x. with:

* Debian 5 (Lenny)
* Debian 6 (Squeeze)
* CentOS 5
* CentOS 6
* CentOS 7
* RedHat 6
* RedHat 7

Over operating systems and support for Puppet 5.x will eventually be added.
Yet feel free to contribute to this module to help us extending the usage of this module.

## Forge Module Dependencies

See [`metadata.json`](https://github.com/Falkor/puppet-ulimit/blob/master/metadata.json).
In particular, this module depends on

* [puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib)

## Overview and Usage

See also [`tests/rule.pp`](https://github.com/Falkor/puppet-ulimit/blob/master/tests/rule.pp)

```ruby
  include ::ulimit

  # This will create the file '/etc/security/limits.d/80_example1.conf' with the
  # following content:
  # *       soft         nofile      1024
  ::ulimit::rule{ 'example1':
      ulimit_domain => '*',
      ulimit_type   => 'soft',
      ulimit_item   => 'nofile',
      ulimit_value  => '1024',
  }

  # This will create the file '/etc/security/limits.d/80_slurm.conf' with the
  # following content:
  #
  # /etc/security/limits.d/80_slurm.conf
  # [...]
  # *       soft         memlock      unlimited
  # *       soft         stack        unlimited
  # *       hard         memlock      unlimited
  # *       hard         stack        unlimited
  #
  ::ulimit::rule{ 'slurm':
      ensure        => 'present',
      ulimit_domain => '*',
      ulimit_type   => [ 'soft', 'hard' ],
      ulimit_item   => [ 'memlock', 'stack' ],
      ulimit_value  => 'unlimited',
  }

  # Below statement should create '/etc/security/limits.d/50_slurm-nproc.conf'
  # with the following content:
  #
  # *       soft         nproc        10240
  # *       hard         nproc        10240
  #
  ::ulimit::rule{ 'slurm-nproc':
      ensure        => 'present',
      priority      => 50,
      ulimit_domain => '*',
      ulimit_type   => [ 'soft', 'hard' ],
      ulimit_item   => 'nproc',
      ulimit_value  => '10240',
  }

  # You can also pass the content yourself -- below statement will create
  # '/etc/security/limits.d/60_content.conf' with that content
  ::ulimit::rule{ 'content':
      ensure   => 'present',
      priority => 60,
      content  => template('ulimit/test.erb'),
  }

  # ... or pass directly the source file -- below statement will create
  # '/etc/security/limits.d/70_source.conf' with that content
  ::ulimit::rule{ 'source':
      ensure   => 'present',
      priority => 70,
      source   => 'puppet:///modules/ulimit/test.conf',
  }
```


## Caveats

By default the module will purge any settings that are not managed by Puppet.
While not advised you can disable this feature:

    node /box/ {
      class { 'ulimit':
        purge => false,
      }
    }

## Developments / Contributing to the code

You are more than welcome to contribute to the development of this module.
Kindly proceed as follows:

1. Fork it
2. Create your feature branch (`git checkout -b feature/<name>`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git flow feature publish <name>`)
5. Create new [Pull request](https://help.github.com/articles/using-pull-requests).

## Puppet modules tests within a Vagrant box

The best way to test this module in a non-intrusive way is to rely on [Vagrant](http://www.vagrantup.com/).
The `Vagrantfile` at the root of the repository pilot the provisioning various vagrant boxes available on [Vagrant cloud](https://atlas.hashicorp.com/boxes/search?utf8=%E2%9C%93&sort=&provider=virtualbox&q=svarrette) you can use to test this module.

## Licence

This project and the sources proposed within this repository are released under the terms of the [Apache-2.0](LICENCE) licence.


[![Licence](https://www.apache.org/images/feather-small.gif)](LICENSE)
