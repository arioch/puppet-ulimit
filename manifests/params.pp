# == Class: ulimit::params
#
class ulimit::params {
  $config_dir   = '/etc/security/limits.d'
  $config_group = 'root'
  $config_user  = 'root'
  $purge        = true
}

