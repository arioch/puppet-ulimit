# Define: rule
#
define ulimit::rule (
  $ulimit_domain,
  $ulimit_type,
  $ulimit_item,
  $ulimit_value,
  $ensure = present,
) {
  File {
    group => $::ulimit::config_group,
    owner => $::ulimit::config_user,
  }

  case $ensure {
    'present': {
      file {
        "${::ulimit::config_dir}/${name}.conf":
          ensure  => $ensure,
          content => template ('ulimit/rule.conf.erb');
      }
    }

    'absent': {
      file {
        "${::ulimit::config_dir}/${name}":
          ensure => $ensure;
      }
    }

    default: {
      fail 'No ensure value found for ulimit rule.'
    }
  }
}

