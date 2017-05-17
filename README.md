# docker-midpoint
Midpoint IM server on a docker container - Centos - Puppet


# Table of Contents

This container contains the Midpoint Identity Management server installation based on Linux Centos 7 & puppet.

## Supported tags

Current branch: latest

*  `3.5.1.1`

For previous versions or newest releases see other branches.

## Introduction

Midpoint is a modern IDM Server (https://evolveum.com/midpoint/) with a community release

### Version

* Version: `3.5.1.1` - Latest



## Installation

Pull the image from docker hub.

```bash
docker pull ffquintella/docker-midpoint:latest
```

Alternately you can build the image locally.

```bash
git clone https://github.com/ffquintella/docker-midpoint.git
cd docker-midpoint
./build.sh
```

## Quick Start

docker run ffquintella/docker-midpoint:latest

## Configuration



### Build Variables

- XXX - The version to be installed

### Extra Variables

- FACTER_XXX - XXX

### Data Store

You can mount directly

- XXX

### User

No special users

### Ports

Next ports are exposed

* `8080/tcp` - default port



## Credits

My thanks to the following

- The Evolveum guys for providing this application
- Every one who worked building docker
- Github for the dvcs support
- Puppet guys for the great tool
