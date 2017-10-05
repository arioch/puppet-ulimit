################################################################################
# Time-stamp: <Thu 2017-10-05 14:45 svarrette>
#
# File::      <tt>rule.pp</tt>
# Author::    Tom De Vylder, Sebastien Varrette
# Copyright:: Copyright (c) 2015-2017 arioch,Falkor
# License::   Apache-2.0
#
# ------------------------------------------------------------------------------
# == Define: ulimit::rule
#
# Add a new ulimit rule within /etc/security/limits.d/
#
# === Parameters:
#
# @param ensure [String] Default: 'present'.
#          Ensure the presence (or absence) of the ulimit rule
# @param content [String]
#          The desired contents of a file, as a string. This attribute is
#          mutually exclusive with source and target.
#          See also
#          https://docs.puppet.com/puppet/latest/types/file.html#file-attribute-content
# @param priority      [Integer] Default: 80
#          Priority of the file, i.e. this rule will create the file
#          '/etc/security/limits.d/<priority>_<label>'
# @param source  [String]
#          A source file, which will be copied into place on the local system.
#          This attribute is mutually exclusive with content and target.
#          See also
#          https://docs.puppet.com/puppet/latest/types/file.html#file-attribute-source
# @param target  [String]
#          See also
#          https://docs.puppet.com/puppet/latest/types/file.html#file-attribute-target
# @param ulimit_domain [String] Default: '*'
#          ulimit Domain, which can be:
#                     - an user name
#                     - a group name, with @group syntax
#                     - the wildcard *, for default entry
#                     - the wildcard %, can be also used with %group syntax,
#                       for maxlogin limit
#                     - NOTE: group and wildcard limits are not applied to root.
#                       To apply a limit to the root user, <domain> must be
#                       the literal username root.
#
# @param ulimit_type   [String or Array]
#                   <type> can have the two values:
#                     - "soft" for enforcing the soft limits
#                     - "hard" for enforcing hard limits
#
# @param ulimit_item    [String or Array]
#                   <item> can be one of the following:
#                     - core - limits the core file size (KB)
#                     - data - max data size (KB)
#                     - fsize - maximum filesize (KB)
#                     - memlock - max locked-in-memory address space (KB)
#                     - nofile - max number of open files
#                     - rss - max resident set size (KB)
#                     - stack - max stack size (KB)
#                     - cpu - max CPU time (MIN)
#                     - nproc - max number of processes
#                     - as - address space limit (KB)
#                     - maxlogins - max number of logins for this user
#                     - maxsyslogins - max number of logins on the system
#                     - priority - the priority to run user process with
#                     - locks - max number of file locks the user can hold
#                     - sigpending - max number of pending signals
#                     - msgqueue - max memory used by POSIX message queues (bytes)
#                     - nice - max nice priority allowed to raise to values:
#                       [-20, 19]
#                     - rtprio - max realtime priority
#                     - chroot - change root to directory (Debian-specific)
#
# @param ulimit_value [String]
#          Value to set for the domain / type
#
define ulimit::rule (
  Enum[
    'present',
    'absent'
  ]       $ensure        = 'present',
  $content               = undef,
  Integer $priority      = 80,
  $source                = undef,
  $target                = undef,
  String  $ulimit_domain = '*',
  $ulimit_type           = undef,
  $ulimit_item           = undef,
  String  $ulimit_value  = '',
)
{
  require ::ulimit
  include ::ulimit::config

  if ($content == undef and $source == undef and $target == undef) {
    if ($ulimit_type == undef or $ulimit_item == undef or empty($ulimit_value)) {
      fail("${module_name} requires the definition of type, item and/or value")
    }
    if ! $ulimit_type.is_a(String) and (! $ulimit_type.is_a(Array)) {
      fail("Parameters ulimit_type is expected to be a string or an Array")
    }
    if ! $ulimit_item.is_a(String) and ! $ulimit_item.is_a(Array) {
      fail("Parameters ulimit_item is expected to be a string or an Array")
    }
  }
  $types = $ulimit_type.is_a(String) ? {
    true    => [ $ulimit_type ],
    default => $ulimit_type,
  }
  $items = $ulimit_item.is_a(String) ? {
    true    => [ $ulimit_item ],
    default => $ulimit_item,
  }
  $real_content = ($content == undef) ? {
    true => ($source == undef) ? {
      true    => template('ulimit/rule.conf.erb'),
      default => undef,
    },
    default => $content,
  }

  file { "${::ulimit::config_dir}/${priority}_${name}.conf":
    ensure  => $ensure,
    content => $real_content,
    source  => $source,
    require => File[$::ulimit::config_dir],
  }

}
