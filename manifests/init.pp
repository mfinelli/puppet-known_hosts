# == Class: known_hosts
#
# This is the main known_hosts class. You must include this in your manifests
# in order to add host keys system-wide. This class sets up the initial
# concat fragment with a header warning.
#
# === Examples
#
#  include '::known_hosts'
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
class known_hosts {
  concat { '/etc/ssh/ssh_known_hosts':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644'
  }

  concat::fragment { 'system known hosts comment':
    order   => '01',
    target  => '/etc/ssh/ssh_known_hosts',
    content => "# KNOWN_HOSTS managed by puppet. Do not edit directly.\n"
  }
}
