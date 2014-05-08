# == Class: php::fpm
#
# Install and configure mod_php for fpm
#
# === Parameters
#
# [*inifile*]
#   The path to the ini php5-fpm ini file
#
# [*settings*]
#   Hash with 'set' nested hash of key => value
#   set changes to augeas when applied to *inifile*
#
# [*user*]
#   user to run default FPM pool as
#
# [*group*]
#   group to run default FPM pool as
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::fpm
#
# === Authors
#
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::fpm(
  $inifile      = $php::params::fpm_inifile,
  $user         = $php::params::fpm_user,
  $group        = undef,
  $settings     = [],
) inherits php::params {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  validate_string($inifile)
  validate_string($user)
  validate_string($group)
  validate_array($settings)

  anchor { 'php::fpm::begin': } ->
    class { 'php::fpm::package': } ->
    php::fpm::config { 'php-fpm':
      file    => $inifile,
      config  => $settings
    } ->
    php::fpm::pool { 'www':
      user  => $user,
      group => $group
    } ->
    class { 'php::fpm::service': } ->
  anchor { 'php::fpm::end': }
}
