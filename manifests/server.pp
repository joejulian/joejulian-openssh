#
# openssh::server is used for installing the server package of openssh
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
#  class { 'openssh::server': }
#
#  class { 'openssh::server':
#    ensure => installed,
#    source => 'puppet:///files/mysshdclientconfig',
#  }
#
# To use hiera:
#  In your manifest:
#    class { 'openssh::server': }
#
#  In your hiera yaml config:
#    openssh::client::ensure: 5.3p1-84.1 
#    openssh::client::source: 'puppet:///files/openssh/sshd_std_config'
#
# === Authors
#
# Joe Julian <me@joejulian.name>
#
# === Copyright
#
# Copyright 2013 Joe Julian <me@joejulian.name>
#
class openssh::server (
  $ensure = latest,
  $source = 'puppet:///modules/openssh/sshd_config'
) inherits openssh {
  file { '/etc/ssh/sshd_config':
    source  => $source,
    mode    => 0600,
    owner   => root,
    notify  => Service[$openssh::params::service],
    require => Package[$openssh::params::server_package],
  }

  package { $openssh::params::server_package: ensure => $ensure }

  service { $openssh::params::service:
    ensure  => running,
    enable  => true,
    require => Package[$openssh::params::server_package],
  }

  @@sshkey { $hostname: host_aliases => $ipaddress, type => rsa, key => $sshrsakey }
  Sshkey <<| |>>
}
