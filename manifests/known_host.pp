# == Define: known_hosts::known_host
#
# This definition actually adds an entry to the known_hosts file.
#
# === Parameters
#
# [*ensure*]
#   Whether or not the entry should be present or not. Valid options are
#   present and absent.
#   Default value: present
#
# [*user*]
#   The user to add the entry for. If left undefined then the entry is added
#   system-wide.
#   Default value: undefined
#
# [*revoked*]
#   Whether the key should be marked as revoked or not. Valid options are
#   true and false.
#   Default value: false
#
# [*host_aliases*]
#   Additional aliases for the host that use the same key. Should be an array
#   of strings.
#   Default value: []
#
# [*type*]
#   The type of key to define. Valid options are any valid key type. See `man
#   sshd` for more information. This parameter is required.
#   Default value: undefined
#
# [*key*]
#   The actual key to include in the entry. Must be a string. This parameter
#   is required.
#   Default value: undefined
#
# === Examples
#
# For a system-wide entry:
#
#  known_hosts::known_host { '10.0.0.1':
#    type => 'ssh-rsa',
#    key  => 'key goes here',
#  }
#
# For a specific user:
#  known_hosts::known_host { '10.0.0.2':
#    user => 'username',
#    type => 'ssh-rsa',
#    key  => 'key goes here',
#  }
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
