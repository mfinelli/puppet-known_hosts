define known_hosts::known_host (
  $ensure       = 'present',
  $user         = undef,
  $revoked      = false,
  $host_aliases = [],
  $key          = undef,
  $type         = undef
) {

  if $user == undef {
    $target = '/etc/ssh/ssh_known_hosts'
  } else {
    $target = "/home/${user}/.ssh/known_hosts"
  }

  if $revoked {
    $revoked_str = '@revoked '
  } else {
    $revoked_str = ''
  }

  $aliases = join(concat(any2array($name), $host_aliases), ',')

  concat::fragment { "${name} known host for ${user}":
    order   => '50',
    target  => $target,
    content => "${revoked_str}${aliases} ${type} ${key}\n"
  }

}
