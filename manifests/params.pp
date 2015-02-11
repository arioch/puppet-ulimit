# == Class: ulimit::params
#
class ulimit::params {
  $config_dir   = '/etc/security/limits.d'
  $config_group = 'root'
  $config_user  = 'root'
  $purge        = true
  $priority     = 80

  # apply default ulimits for OS if found
  $use_default_ulimits = true

  # ulimit defaults
  case $::operatingsystem {
    RedHat,CentOS,Scientific: {

      if $::operatingsystemmajrelease == 5 {
        # pam package on EL5 doesn't create anything
        $default_ulimits = {}
      } elsif $::operatingsystemmajrelease == 6 {
        # pam package on EL6 creates 90-nproc.conf
        $default_ulimits = {
          'nproc' => {
            'ulimit_comment'	  => "# Default limit for number of user's processes to prevent\n# accidental fork bombs.\n# See rhbz #432903 for reasoning.",
            'ulimit_domain'     => [ '*', 'root', ],
            'ulimit_type'       => [ 'soft', 'soft', ],
            'ulimit_item'       => [ 'nproc', 'nproc', ],
            'ulimit_value'      => [ '1024', 'unlimited' ],
            'priority'          => '90',
          },
        }
      } elsif $::operatingsystemmajrelease == 7 {
        # pam package on EL7 creates 20-nproc.conf
        $default_ulimits = {
          'nproc' => {
            'ulimit_comment'	  => "# Default limit for number of user's processes to prevent\n# accidental fork bombs.\n# See rhbz #432903 for reasoning.",
            'ulimit_domain'     => [ '*', 'root', ],
            'ulimit_type'       => [ 'soft', 'soft', ],
            'ulimit_item'       => [ 'nproc', 'nproc', ],
            'ulimit_value'      => [ '4096', 'unlimited' ],
            'priority'          => '20',
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

