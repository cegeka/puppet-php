# == Class: php::phpunit
#
# Install phpunit, PHP testing framework
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::phpunit
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Tobias Nyholm <tobias@happyrecruiting.se>
#
# === Copyright
#
# See LICENSE file
#

#FIXME: no pear
class php::phpunit (
  $package  = 'pear.phpunit.de/PHPUnit',
  $provider = 'pear'
) {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  package { $package:
    ensure    => present,
    provider  => $provider;
  }

  Exec['php::pear::auto_discover'] -> Package[$package]
}
