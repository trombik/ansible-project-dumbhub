## `virtualbox` environment

This is an environment for development on local machine. The environment is
created by `virtualbox`.

### Instances

#### `dumbhub`

This is the target machine to create.

It has four network interfaces.

* One for the default network, through which the machine access the Internet.
  This interface is required in `virtualbox` environment, but not in
  production.
* Two interfaces for bridging. One is connected to `peer`, and another to
  `router`. Packets to/from `router` are forwarded via a bridge interface
  whose member interfaces are these two physical interfaces.
* One for the internal network, used for the machine to provide services to
  the internal clients. `ansible` manages the host using this interface.

#### `router`

This is an instance to mock a router that performs NAT for internal clients,
and acts as the default gateway of the internal network.

One network interface is connected to `dumbhub`.

#### `peer`

This is an instance to mock a peer device of your ISP.

One network interface is connected to `dumbhub`.
