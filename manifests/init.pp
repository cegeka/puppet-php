# == Class: php
#
# PHP base class
#
# === Parameters
#
# usephp54: false : installs php-pear
#           true  : install php54-pear
#
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php:
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php ($phpversion=undef) {

  include php::params

  exec { 'php::pear::auto_discover':
    command => 'pear config-set auto_discover 1 system',
    unless  => 'pear config-get auto_discover system | grep -q 1',
    path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ];
  }

  case $phpversion {
    52: { $packagename = php-pear }
    54: { $packagename = php54-pear }
    55: { $packagename = php55u-pear }
    default: { $packagename = php-pear }
  }

  package { $packagename:
    ensure => $php::params::ensure
  } -> Exec['php::pear::auto_discover']

}
