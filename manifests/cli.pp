# == Class: php::cli
#
# Install and configure php CLI
#
# === Parameters
#
# [*ensure*]
#   The PHP ensure of PHP CLI to install
#
# [*package*]
#   The package name for PHP CLI
#   For debian it's php5-cli
#
# [*inifile*]
#   The path to the ini php5-cli ini file
#
# [*settings*]
#   Hash with nested hash of key => value to set in inifile
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::cli(
  $ensure   = $php::ensure,
  $package  = $php::params::cli_package,
  $inifile  = $php::params::cli_inifile,
  $settings = {}
) inherits php::params {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  package { $package:
    ensure => $ensure,
  } ->
  php::config { 'cli':
    file   => $inifile,
    config => $settings
  }
}
