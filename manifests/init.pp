# Class: ulimit
#
# This class installs ulimit
#
# Parameters:
#
# Actions:
#   - Install ulimit
#
# Requires:
#
# Sample Usage:
#  node host01 {
#    class { 'ulimit': }
#
#    ulimit::rule {
#      'foo1':
#        ensure        => present,
#        ulimit_domain => 'domain',
#        ulimit_type   => 'type',
#        ulimit_item   => 'item',
#        ulimit_value  => 'value',
#      'foo2':
#        ensure        => present,
#        ulimit_domain => 'domain',
#        ulimit_type   => 'type',
#        ulimit_item   => 'item',
#        ulimit_value  => 'value',
#    }
#  }
#
class ulimit {
  class { 'ulimit::params': }
  class { 'ulimit::config': }

  Class['ulimit::params'] ->
  Class['ulimit::config']

  # Define: rule
  # Parameters:
  #  $ensure, $ulimit_domain, $ulimit_type, $ulimit_item, $ulimit_value
  #
  define rule ( $ensure, $ulimit_domain, $ulimit_type, $ulimit_item, $ulimit_value ) {
    case $ensure {
      'present': {
        file {
          "$ulimit::params::ulimit_confdir/${name}.conf":
            ensure  => file,
            content => template ('ulimit/rule.conf.erb');
        }
      }

      'absent': {
        file {
          "$ulimit::params::ulimit_confdir/${name}":
            ensure => absent;
        }
      }

      default: {
        fail 'No ensure value found for ulimit rule.'
      }
    }
  }
}
