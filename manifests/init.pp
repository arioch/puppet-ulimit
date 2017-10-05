################################################################################
# Time-stamp: <Thu 2017-10-05 11:41 svarrette>
#
# File::      <tt>init.pp</tt>
# Author::    Tom De Vylder, Sebastien Varrette
# Copyright:: Copyright (c) 2015-2017 arioch,Falkor
# License::   Apache-2.0
#
# ------------------------------------------------------------------------------
# == Class: ulimit
#
# ulimit provides control over the resources available to the shell and to
# processes started by it, on systems that allow such control.
# This class offers the ulimit::rule definition which permits to define soft
# and/or hard limits over various domains.
# - The soft limit is the value that the kernel enforces for the corresponding
# resource.
# - The hard limit acts as a ceiling for the soft limit.
#
# @param config_dir          [String]  Default: '/etc/security/limits.d'
# @param config_group        [String]  Default: 'root'
# @param config_user         [String]  Default: 'root'
# @param use_default_ulimits [String]  Default: true
#         If true, then default ulimit configuration for the OS/release is
#         applied (if found)
# @param purge               [String]  Default: true
#
class ulimit (
  String  $config_dir          = $ulimit::params::config_dir,
  String  $config_group        = $ulimit::params::config_group,
  String  $config_user         = $ulimit::params::config_user,
  Boolean $use_default_ulimits = $ulimit::params::use_default_ulimits,
  Boolean $purge               = $ulimit::params::purge,
)
inherits ::ulimit::params
{
  $default_ulimits = $ulimit::params::default_ulimits
  include ::ulimit::config
}
