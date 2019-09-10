## Simple PowerDNS recursor container

### Sources
Base image: [centos:latest](https://hub.docker.com/_/centos)  
Software: [PowerDNS](https://www.powerdns.com/)

### Requirements:
Working Docker installation.

### Usage

#### Persistence
All the required configuration is already present so nothing is required for persistency. However; you can add a lot of custom parameters to the configurations files supported by the PowerDNS recursor. All configuration files in /etc/pdns-recursor/conf.d/ are loaded into the instance. To put custom configuration there simply mount a file as volume and put your extra configuration in there. 

The docker-compose example below has a working configuration set to support RPZ through LUA.

#### Docker-compose example
```
services:
  powerdns-recursor:
    image: jerheij/powerdns-recursor:latest
    restart: always
    volumes:
      - recursor.conf:/etc/pdns-recursor/conf.d/custom.conf:ro
      - conf.lua:/etc/pdns-recursor/conf.lua:ro
      - override.rpz:/etc/pdns-recursor/override.rpz:ro
    environment:
      DOMAINS:
        thuis.local
        docker.local
      DOMAINS_FORWARDER: 192.168.1.10
      WILDCARD_FORWARDERS: 208.67.222.222;208.67.220.220

```

#### Configuration
This PowerDNS recursor is set-up in such a way to deploy it with a minimal amount of configuration. See the parameters below for the supported configuration.

### Variables
| Variable | Function | Optional |
| --- | --- | --- |
| `DOMAINS` | Domains the recursor needs to forward to a specific DNS (regular PowerDNS instance) | no |
| `DOMAINS_FORWARDER`| The IP address of the forwarder for the domains variable | no |
| `WILDCARD_FORWARDERS`| The IP address of the DNS server the recursor needs to forward all other queries to | no |

### Author
Jerheij