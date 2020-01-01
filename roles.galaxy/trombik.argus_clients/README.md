# `trombik.argus_clients`

[![Build Status](https://travis-ci.com/trombik/ansible-role-argus_clients.svg?branch=master)](https://travis-ci.com/trombik/ansible-role-argus_clients)

`ansible` role for `argus_clients`. This role simply installs client tools for
`argus(8)`, i.e. `ra(1)`, `rahisto(1)`, and other tools in `argus-clients`.

# Requirements

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `argus_clients_package` | Package name of `argus_clients` | `{{ __argus_clients_package }}` |
| `argus_clients_extra_packages` | A list of extra package to install | `[]` |

## Debian

| Variable | Default |
|----------|---------|
| `__argus_clients_package` | `argus-client` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__argus_clients_package` | `net-mgmt/argus3-clients` |

## OpenBSD

| Variable | Default |
|----------|---------|
| `__argus_clients_package` | `argus-clients` |

## RedHat

| Variable | Default |
|----------|---------|
| `__argus_clients_package` | `argus-clients` |

# Dependencies

# Example Playbook

```yaml
---
- hosts: localhost
  roles:
    - role: trombik.redhat_repo
      when:
        - ansible_os_family == 'RedHat'
    - ansible-role-argus_clients
  pre_tasks:
    - name: Dump all hostvars
      debug:
        var: hostvars[inventory_hostname]
  post_tasks:
    - name: List all services (systemd)
      # workaround ansible-lint: [303] service used in place of service module
      shell: "echo; systemctl list-units --type service"
      changed_when: false
      when:
        - ansible_os_family == 'RedHat' or ansible_os_family == 'Debian'
    - name: list all services (FreeBSD service)
      # workaround ansible-lint: [303] service used in place of service module
      shell: "echo; service -l"
      changed_when: false
      when:
        - ansible_os_family == 'FreeBSD'
  vars:
    redhat_repo_extra_packages:
      - epel-release
    redhat_repo:
      epel:
        mirrorlist: "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-{{ ansible_distribution_major_version }}&arch={{ ansible_architecture }}"
        gpgcheck: yes
        enabled: yes
```

# License

```
Copyright (c) 2016 Tomoyuki Sakurai <y@trombik.org>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <y@trombik.org>
