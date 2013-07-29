# == Class: php::extension::newrelic::params
#
# Defaults file for the newrelic PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The version of the package to install
#   Could be "latest", "installed" or a pinned version
#   This matches "ensure" from Package
#
# [*package*]
#   The package name in your provider
#
# [*provider*]
#   The provider used to install the package
#
# [*inifile*]
#   The path to the extension ini file
#
# [*settings*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *inifile*
#
# === Examples
#
# No examples
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::newrelic::params {

  $ensure   = $php::params::ensure
  $package  = 'newrelic-php5'
  $provider = undef
  $inifile  = '/etc/php5/conf.d/newrelic.ini'
  $settings = {
    set => {

    }
  }

}
