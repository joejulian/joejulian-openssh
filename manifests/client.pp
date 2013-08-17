#
# openssh::client is used for installing the client package of openssh
# and configuring sane defaults
#
# === Parameters
#
# [*ensure*]
#   Set the ensure parameter of the package.
#
# [*source*]
#   Set the source path for the configuration file.
#
# === Examples
#
#  class { 'openssh::client': }
#
#  class { 'openssh::client':
#    ensure => installed,
#    source => 'puppet:///files/mysshclientconfig',
#  }
#
# To use hiera:
#  In your manifest:
#    class { 'openssh::client': }
#
#  In your hiera yaml config:
#    openssh::client::ensure: 5.3p1-84.1
#    openssh::client::source: 'puppet:///files/openssh/ssh_std_config'
#
# === Authors
#
# Joe Julian <me@joejulian.name>
#
# === Copyright
#
# Copyright 2013 Joe Julian <me@joejulian.name>
#
class openssh::client (
  $ensure = 'latest',
  $source = 'puppet:///modules/openssh/ssh_config'
) inherits openssh {
  package { $openssh::params::client_package: ensure => $ensure }

  file { '/etc/ssh/ssh_config':
    source  => $source,
    owner   => 'root',
    mode    => '0644',
    require => Package[$openssh::params::client_package],
  }
}
