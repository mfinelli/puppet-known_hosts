# == Define: known_hosts::user
#
# This definition sets up the known_hosts file for a given user.
#
# === Examples
#
#  known_hosts::user { 'username': }
#
# === Authors
#
# Mario Finelli <mario@finel.li>
#
# === Copyright
#
# Copyright 2015 Mario Finelli
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
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
    order   => '01',
    target  => "/home/${name}/.ssh/known_hosts",
    content => "# KNOWN_HOSTS managed by puppet. Do not edit directly.\n"
  }
}
