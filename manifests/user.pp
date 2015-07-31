define known_hosts::user {
  file { "/home/${name}/.ssh":
    ensure => 'directory',
    owner  => $name,
    group  => $name,
    mode   => '0700'
  }

  concat { "/home/${name}/.ssh/known_hosts":
    ensure  => present,
    owner   => $name,
    group   => $name,
    mode    => '0644',
    require => File["/home/${name}/.ssh"]
  }

  concat::fragment { "${name}'s local known hosts header":
    order => '01',
    target => "/home/${name}/.ssh/known_hosts",
    content => "# KNOWN_HOSTS managed by puppet. Do not edit directly.\n"
  }
}
