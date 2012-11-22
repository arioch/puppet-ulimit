# Puppet Ulimit

## Requirements

## Tested on...

* Debian 5 (Lenny)
* Debian 6 (Squeeze)

## Example usage

    node /box/ {
      include ulimit

      ulimit::rule { 'foo1':
        ensure        => present,
        ulimit_domain => 'domain',
        ulimit_type   => 'type',
        ulimit_item   => 'item',
        ulimit_value  => 'value',
      }
    }

