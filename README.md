## Sample usage

    node host01 {
      class { 'ulimit': }

      ulimit::rule {
        'foo1':
          ensure        => present,
          ulimit_domain => 'domain',
          ulimit_type   => 'type',
          ulimit_item   => 'item',
          ulimit_value  => 'value',
        'foo2':
          ensure        => present,
          ulimit_domain => 'domain',
          ulimit_type   => 'type',
          ulimit_item   => 'item',
          ulimit_value  => 'value',
      }
    }
