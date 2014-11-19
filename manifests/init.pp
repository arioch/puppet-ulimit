# == Class: ulimit
#
# === Parameters
#
# [*use_default_ulimits*]
#   Boolean. If true, then default ulimit configuration for the OS/release is
#   applied (if found)
#   Default: true
#
class ulimit (
  $config_dir          = $ulimit::params::config_dir,
  $config_group        = $ulimit::params::config_group,
  $config_user         = $ulimit::params::config_user,
  $use_default_ulimits = $ulimit::params::use_default_ulimits,
  $purge               = $ulimit::params::purge,
) inherits ulimit::params {
  $default_ulimits = $ulimit::params::default_ulimits
  include ulimit::config
}

