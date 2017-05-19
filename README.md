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

- JAVA_HOME Where java is installed
- MIDPOINT_VERSION The midpoint version installed
- MIDPOINT_HOME where midpoint variable files will be hosted
- MIDPOINT_INSTALL_DIR where midpoint is installed
- TOMCAT_VERSION The version of the comcat application server used
- JAVA_OPTS Extra variables like memory and keystore



### Data Store

You can mount directly

- /var/opt/midpoint - midpoint variable files

### User

Files are created under tomcat user (uid 1000)

### Ports

Next ports are exposed

* `8080/tcp` - default port


## Credits

My thanks to the following

- The Evolveum guys for providing this application
- Every one who worked building docker
- Github for the dvcs support
- Puppet guys for the great tool
