# Tyk Pro Demo using Docker

## Quick start

**Prerequisites**

- [Docker](https://docs.docker.com/get-docker/)

Once you have a license, run these commands:

1. `git clone https://github.com/TykTechnologies/tyk-pro-docker-demo && cd tyk-pro-docker-demo`

2. `up.sh`

hint: you may need to give the executable permissions if you have an error:

```bash
chmod +x up.sh
```

Then check the terminal output to log in with your created user.

This will build an API that is protected by the following authentication token:
`my_custom_key`

The repository extends the [docker-pro-demo](https://github.com/TykTechnologies/tyk-pro-docker-demo) repository.
Further advanced configuration with MongoDB, PostgreSQL can be found there.

An RSA key pair will be generated and stored in the _confs/keys_ folder. These can
be used to sign plugin bundles.

## Plugins

This repository contains a basic example of a plugin in the following languages:

- GoLang 1.19
- JVM
- Python

It does not target gRPC.

The plugin logs to the console when each hook is activated.

### Overview

A _Makefile_ has been created to start a Tyk Self Managed docker-compose stack for each
specific language.

The docker-compose stack consists of an Nginx instance to serve signed plugin
bundles. To generate the RSA key pairs enter the following command from within the
root of the repository:

```console
make gen-keys
```

Alternatively if you have ran the _up.sh_ command to setup the repository then
the keys will have been generated for you in the _confs/keys_ folder.

N.B the data storage volume is currently shared across docker-compose stacks.

Subsequently, for each language it will be necessary to update the plugin bundle
for the API.

There is a _plugins_ folder that contains a _logger_ plugin, with subfolders for:

- Go
- Javascript
- Python

Each subfolder has a _Makefile_ for building and bundling the plugin as a signed zip file.
Please refer to the README file within each subfolder for an overview of the
specific make rules provide for each language.

The following table summarises how to start the plugin

| Language | Rule           | Description                                                 |
| -------- | -------------- | ----------------------------------------------------------- |
| Go       | go-up          | Start Go plugin docker-compose stack                        |
|          | go-down        | Stop Go plugin docker-compose stack                         |
|          | go-logs        | Shows logs for Go docker-compose stack                      |
|          | go-restart     | Restart services for Go docker-compose stack                |
| JS       | js-up          | Start JS Go plugin docker-compose stack                     |
|          | js-down        | Stop JS plugin docker-compose stack                         |
|          | js-logs        | Show logs for JS docker-compose stack                       |
|          | js-up          | Start JS plugin docker-compose stack                        |
|          | js-restart     | Restart docker-compose services for JS docker-compose stack |
| Python   | python-up      | Start Python docker-compose stack                           |
|          | python-down    | Stop Python docker-compose stack                            |
|          | python-logs    | Show logs for Python docker-compose stack                   |
|          | [ython-restart | Restart services for Python docker-compose stack            |
