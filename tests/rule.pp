#
# You can execute this manifest as follows in your vagrant box
#
#      sudo puppet apply -vt /vagrant/tests/rule.pp
#
node default {
  include ::ulimit
  $ensure = 'present'  #  'absent'

  # This will create the file '/etc/security/limits.d/80_example1.conf' with the
  # following content:
  #
  # *       soft         nofile      1024
  #
  ::ulimit::rule{ 'example1':
    ensure        => $ensure,
    ulimit_domain => '*',
    ulimit_type   => 'soft',
    ulimit_item   => 'nofile',
    ulimit_value  => '1024',
  }

  # This will create the file '/etc/security/limits.d/80_example2.conf' with the
  # following content:
  #
  # *       hard         nproc        1024
  # *       hard         nofile       1024
  #
  ::ulimit::rule{ 'example2':
    ensure        => $ensure,
    ulimit_domain => '*',
    ulimit_type   => 'hard',
    ulimit_item   => [ 'nproc', 'nofile' ],
    ulimit_value  => '1024',
  }

  # This will create the file '/etc/security/limits.d/80_slurm.conf' with the
  # following content:
  # [...]
  # *       soft         memlock      unlimited
  # *       soft         stack        unlimited
  # *       hard         memlock      unlimited
  # *       hard         stack        unlimited
  #
  ::ulimit::rule{ 'slurm':
    ensure        => $ensure,
    ulimit_domain => '*',
    ulimit_type   => [ 'soft', 'hard' ],
    ulimit_item   => [ 'memlock', 'stack' ],
    ulimit_value  => 'unlimited',
  }

  # Below statement should create '/etc/security/limits.d/50_slurm-nproc.conf'
  # with the following content:
  # [...]
  # *       soft         nproc        10240
  # *       hard         nproc        10240
  #
  ::ulimit::rule{ 'slurm-nproc':
    ensure        => $ensure,
    priority      => 50,
    ulimit_domain => '*',
    ulimit_type   => [ 'soft', 'hard' ],
    ulimit_item   => 'nproc',
    ulimit_value  => '10240',
  }

  # You can also pass the content yourself -- below statement will create
  # '/etc/security/limits.d/60_content.conf' with that content
  #
  ::ulimit::rule{ 'content':
    ensure   => $ensure,
    priority => 60,
    content  => template('ulimit/test.erb'),
  }

  # ... or pass directly the source file -- below statement will create
  # '/etc/security/limits.d/70_source.conf' with that content
  #
  ::ulimit::rule{ 'source':
    ensure   => $ensure,
    priority => 70,
    source   => 'puppet:///modules/ulimit/test.conf',
  }

}
