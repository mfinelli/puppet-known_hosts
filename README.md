# known_hosts

[![Build Status](https://travis-ci.org/mfinelli/puppet-known_hosts.svg?branch=master)](https://travis-ci.org/mfinelli/puppet-known_hosts)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with known_hosts](#setup)
    * [What known_hosts affects](#what-known_hosts-affects)
    * [Beginning with known_hosts](#beginning-with-known_hosts)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A puppet module to manage the known_hosts files for users and the system.

## Module Description

The module will manage the `/etc/ssh/ssh_known_hosts` and and users'
`~/.ssh/known_hosts` that you configure it for. It will purge any unmanaged
entries from these files. This is different from the `sshkey` resource, which
does not purge entries and only manages the system-wide known hosts.

## Setup

### What known_hosts affects

* Entries in `/etc/ssh/ssh_known_hosts` (Purges unmanaged entries!)
* Entries in `~/.ssh/known_hosts` for a given user (Also purges unmanaged
  entries!)

### Beginning with known_hosts

To purge all entries in the system's `known_hosts`:

```puppet
include ::known_hosts
```

To purge a given user's `known_hosts`:

```puppet
::known_hosts::user { 'user': }
```

## Usage

At this point you can add back entries to the files. For system-wide:

```puppet
::known_hosts::known_host { 'example.com':
  type => 'ssh-rsa',
  key  => 'key goes here',
}
```

Or, for a specific user:

```puppet
::known_hosts::known_host { 'example.com':
  user => 'user',
  type => 'ssh-rsa',
  key  => 'key goes here',
}
```

## Reference

### Classes

#### Public classes

* known_hosts: main class, sets up the system-wide known_hosts file

### Defined types

* known_hosts::user: sets up the known_hosts file for a user
* known_hosts::known_host: adds an entry to the known_hosts file

### Parameters: `known_hosts::known_host`

The following parameters are available to the known_hosts::known_host defined
type.

#### `ensure`

Whether or not the entry should be present or not.

#### `user`

The user to add the entry for. If left undefined then the entry is added
system-wide (default).

#### `revoked`

Whether the key should be marked as revoked or not. Default is not revoked.

#### `host_aliases`

Additional aliases for the host that use the same key. Should be an array
aliases.

#### `type`

The type of key to define. Valid options are any valid key type. See `man
sshd` for more information.

#### `key`

The actual key to include in the entry.

## Limitations

This module has been tested on:

* Debian 8 (jessie)

## Development

This module is still under development. If you would like to help (especially
for platforms other than Debian) please send fork the project at
[GitHub](https://github.com/mfinelli/puppet-known_hosts) and send a pull
request. New features belong in a feature branch named `feature/your-feature`
and the pull request should be against the
[develop](https://github.com/mfinelli/puppet-known_hosts/tree/develop)
branch. Please add your name below and to the authors section of any file
that you modify. While not required, it would be nice if you wrote test cases
for any functionality that you add.

## Authors

* Mario Finelli

## License

Copyright 2015 Mario Finelli

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
