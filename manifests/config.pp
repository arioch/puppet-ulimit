# Class: ulimit::config
#
#
class ulimit::config {
  file {
    $ulimit::params::ulimit_confdir:
      ensure  => directory,
      recurse => true,
      purge   => true;
  }
}
