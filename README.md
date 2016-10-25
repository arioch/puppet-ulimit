# Puppet Ulimit

## Requirements

## Tested on...

* Debian 5 (Lenny)
* Debian 6 (Squeeze)
* CentOS 5
* CentOS 6
* CentOS 7

## Example usage

    node /box/ {
      include ulimit

      ulimit::rule {
        'example1':
          ulimit_domain => ['*'],
          ulimit_type   => ['soft'],
          ulimit_item   => ['nofile'],
          ulimit_value  => ['1024'];
        'example2':
          ensure => absent,
          ulimit_domain => ['*'],
          ulimit_type   => ['soft'],
          ulimit_item   => ['nofile'],
          ulimit_value  => ['1024'];
        'example3':
          ulimit_domain => ['*', '*', '*'],
          ulimit_type   => ['soft', 'hard', 'soft'],
          ulimit_item   => ['nofile', 'nofile', 'stack'],
          ulimit_value  => ['1024', '32768', '65536'],
      }
    }

## Caveats

By default the module will purge any settings that are not managed by Puppet.
While not advised you can disable this feature:

    node /box/ {
      class { 'ulimit':
        purge => false,
      }
    }

Domain, type, item and value parameters must be arrays -- even if there is only one value.

