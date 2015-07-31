# == Class: known_hosts
#
# Full description of class known_hosts here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the function of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'known_hosts':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class known_hosts {
  concat { '/etc/ssh/ssh_known_hosts':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644'
  }

  concat::fragment { 'system known hosts comment':
    order => '01',
    target => '/etc/ssh/ssh_known_hosts',
    content => "# KNOWN_HOSTS managed by puppet. Do not edit directly.\n"
  }
}
