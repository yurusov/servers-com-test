# ServersComTest

[![Build](https://github.com/yurusov/servers-com-test/actions/workflows/docker-build.yml/badge.svg)](https://github.com/yurusov/servers-com-test/actions/workflows/docker-build.yml)
[![Coverage](https://yurusov.github.io/servers-com-test/badge.svg)](https://yurusov.github.io/servers-com-test/index.html)
[![Depfu](https://img.shields.io/depfu/dependencies/github/yurusov/servers-com-test)](Gemfile)
[![GitHub issues](https://img.shields.io/github/issues/yurusov/servers-com-test)](https://github.com/yurusov/servers-com-test/issues)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/yurusov/servers-com-test)](https://github.com/yurusov/servers-com-test/releases)
[![GitHub top language](https://img.shields.io/github/languages/top/yurusov/servers-com-test)](https://github.com/yurusov/servers-com-test/search?l=ruby)
[![GitHub](https://img.shields.io/github/license/yurusov/servers-com-test)](LICENSE)


This is an Hanami 2 application.

## Local development

To set up the app:

```sh
$ ./bin/setup
```

To run the tests:

> Some tests require root privileges or setcap net_raw 

```sh
$ bundle exec rspec
```

Also don't forget to use rubocop linter:

```sh
$ bundle exec rubocop
```

To start the app:

```sh
$ bundle exec hanami server
```

To start worker:
> Requires root privileges or setcap net_raw 

```sh
$ ruby lib/ping_worker.rb   
```

## Docker image

You can pull last builded docker image from *harbor.yurusov.com/public/servers-com-test:main*
or use	[docker-compose](./docker-compose.yml) instead


## Additional info

Original task(in russian) can be found [here](TASK.md)
