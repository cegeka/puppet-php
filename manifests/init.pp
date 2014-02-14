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
class php ($usephp54 = false) {

  include php::params

  exec { 'php::pear::auto_discover':
    command => 'pear config-set auto_discover 1 system',
    unless  => 'pear config-get auto_discover system | grep -q 1',
    path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ];
  }

  if ($usephp54) {
    $packagename = php54-pear
  } else {
    $packagename = php-pear
  }

  package { $packagename:
    ensure => $php::params::ensure
  } -> Exec['php::pear::auto_discover']

}
