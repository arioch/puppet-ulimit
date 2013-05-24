# == Class: ulimit
#
class ulimit (
  $config_dir   = $ulimit::params::config_dir,
  $config_group = $ulimit::params::config_group,
  $config_user  = $ulimit::params::config_user,
  $purge        = $ulimit::params::purge
) inherits ulimit::params {
  include ulimit::config
}

