# == Class: ulimit::config
#
class ulimit::config {
  File {
    group => $::ulimit::config_group,
    owner => $::ulimit::config_user,
  }

  file { $::ulimit::config_dir:
    ensure  => directory,
    recurse => true,
    purge   => $::ulimit::purge,
  }
}

