# == Class: php::extension
#
# Install a PHP extension package
#
# === Parameters
#
# [*ensure*]
#   The ensure of the package to install
#   Could be "latest", "installed" or a pinned version
#
# [*package*]
#   Package name as defined in the package provider
#
# [*provider*]
#   The provider used to install the package
#   Could be "pecl", "apt", "dpkg" or any other OS package provider
#
# [*pipe*]
#   Used to answer interactive questions from pecl
#   Some extensions require answers on different questions. To provide answers
#   supply a list of lines with answers - one answer per line
#
# [*source*]
#   The path to the deb package to install
#
# === Variables
#
# [*php_ensure*]
#   The ensure of APC to install
#
# === Examples
#
# php::extension { "apc": }
#
# $answers = "shared
# /usr
# all"
# php::extension { 'libenchant':
#   ensure   => "latest",
#   package  => "enchant",
#   provider => "pecl",
#   pipe     => $answers;
# }
#
# php::extension { 'gearman':
#   ensure   => "latest",
#   package  => "libgearman8",
#   provider => "dpkg",
#   source   => "/path/to/libgearman8_1.1.7-1_amd64.deb";
# }
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
define php::extension(
  $ensure,
  $provider = undef,
  $package  = undef,
  $source   = undef,
  $config   = []
) {

  if $package {
    $real_package = $package
  } elsif $provider == 'pecl' {
    $real_package = $title
  } else {
    $real_package = "php5-${title}"
  }

  if $provider == 'pecl' and defined(Package[$real_package]) {
    # FIXME: due to multiple package declarations we cannot rely on package here currently
    # e.g. you cannot install package memcached with two different providers
    # https://tickets.puppetlabs.com/browse/PUP-1073
    if $ensure =~ /present|latest|absent/ {
      $command = "pecl install ${real_package}"
    } else {
      $command = "pecl install ${real_package}-${ensure}"
    }

    exec { "pecl-install-${real_package}":
      command => $command,
      unless  => "pecl list | grep -iw ${real_package}",
      user    => 'root',
      path    => ['/bin', '/usr/bin']
    }
  } elsif $provider == 'dpkg' {
    package { $real_package:
      ensure   => $ensure,
      provider => $provider,
      source   => $source;
    }
  } else {
    package { $real_package:
      ensure   => $ensure,
      provider => $provider;
    }
  }

  $real_config = $provider ? {
    'pecl'  => concat(["set .anon/extension '${title}.so'"], $config),
    default => $config
  }
  php::config { $title:
    file   => "${php::params::config_root_ini}/${downcase($title)}.ini",
    config => $real_config
  }
}
