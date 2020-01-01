# `trombik.netstart`

Manage `hostname.if(5)` and automatically restart interfaces.

# Requirements

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `netstart_extra_packages` | A list of packages to install | `[]` |
| `netstart_config_dir` | Path to base directory of `hostname.if(5)` | `/etc` |
| `netstart_config` | See below | `[]` |
| `netstart_force_flush_handlers` | If true, flush all handlers at the end of the role | `no` |

## `netstart_config`

This is a list of dict. Interfaces are configured and restarted in the order
of this list. An interface that is required by another interface should be
defined first.

| Key | Description | Required? |
|-----|-------------|-----------|
| `name` | Name of network interface | Yes |
| `content` | The content of `hostname.if(5)` | Yes |

# Dependencies

None.

# Example Playbook

```yaml
---
- hosts: localhost
  roles:
    - ansible-role-netstart
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
        # in docker, init is not systemd
        - ansible_virtualization_type != 'docker'
        - ansible_os_family == 'RedHat' or ansible_os_family == 'Debian'
    - name: list all services (FreeBSD service)
      # workaround ansible-lint: [303] service used in place of service module
      shell: "echo; service -l"
      changed_when: false
      when:
        - ansible_os_family == 'FreeBSD'
  vars:
    netstart_force_flush_handler: yes
    netstart_config:
      - name: vether0
        content: |
          up
      - name: bridge0
        content: |
          add em0
          add vether0
          up
```

# License

```
Copyright (c) 2020 Tomoyuki Sakurai <y@trombik.org>

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
