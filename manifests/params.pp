#
# openssh::params is used for setting distribution specific parameters
#
# === Examples
#
# This class is not used directly
#
# === Authors
#
# Joe Julian <me@joejulian.name>
#
# === Copyright
#
# Copyright 2013 Joe Julian <me@joejulian.name>
#
class openssh::params {
  $client_package = $::osfamily ? {
    'RedHat' => 'openssh-clients',
    'Debian' => 'openssh-client',
    default  => undef,
  }

  $server_package = 'openssh-server'
  $service = 'sshd'
}
