# sweet-dns

# Overview

Several articles of DNS development solutions for local environments in MacOS refer to the dnsmasq server along with system resolvers, but it is a bit complicated. In this scenario, sweet-dns arises to reduce the complexity of the process, seeking to be a simple and efficient tool.

# How it works

sweet-dns uses dnsmasq as the main dns server of the system running on localhost and as the only option for the default `resolv.conf` system, on the other hand, dnsmasq uses the DNS of the active network connection, found in `/var/run/resolv.conf`, for internet name resolution after the resolution of local registries (rewriting the result if it locally points to another IP). The sweet-dns solution allows you to add as many local dns records as you prefer even occupying any internet domain.

# Examples

```bash
sweet-dns -d dev
sweet-dns -d dvp -d test
```

# Installation

Just run:

```console
curl -L https://git.io/fj9Jj | bash
```


