# == Class: ulimit::params
#
class ulimit::params {
  $config_dir   = '/etc/security/limits.d'
  $config_group = 'root'
  $config_user  = 'root'
  $priority     = 80
  $purge        = true

  # apply default ulimits for OS if found
  $use_default_ulimits = hiera('use_default_ulimits',true)

  # ulimit defaults
  case $::operatingsystem {
    'RedHat','CentOS','Scientific': {
      if $::operatingsystemmajrelease == '5' {
        # pam package on EL5 doesn't create anything
        $default_ulimits = {}
      } elsif $::operatingsystemmajrelease == '6'  {
        # pam package on EL6 creates 90-nproc.conf
        $default_ulimits = {
          'nproc_user_defaults' => {
            'priority'          => '90',
            'ulimit_domain'     => '*',
            'ulimit_item'       => 'nproc',
            'ulimit_type'       => 'soft',
            'ulimit_value'      => '1024',
          },
          'nproc_root_defaults' => {
            'priority'          => '90',
            'ulimit_domain'     => 'root',
            'ulimit_item'       => 'nproc',
            'ulimit_type'       => 'soft',
            'ulimit_value'      => 'unlimited',
          },
        }
      } elsif $::operatingsystemmajrelease == '7' {
        # pam package on EL7 creates 20-nproc.conf
        $default_ulimits = {
          'nproc_user_defaults' => {
            'priority'          => '20',
            'ulimit_domain'     => '*',
            'ulimit_item'       => 'nproc',
            'ulimit_type'       => 'soft',
            'ulimit_value'      => '4096',
          },
          'nproc_root_defaults' => {
            'priority'          => '20',
            'ulimit_domain'     => 'root',
            'ulimit_item'       => 'nproc',
            'ulimit_type'       => 'soft',
            'ulimit_value'      => 'unlimited',
          },
        }
      } else {
        # if some other release then don't risk destroying default config
        fail("Unsupported operatingsystemmajrelease: ${::operatingsystemmajrelease}")
      }
    } default: {
      $default_ulimits = {}
    }
  }
}

