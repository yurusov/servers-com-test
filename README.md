# ServersComTest

[![Build](https://github.com/yurusov/servers-com-test/actions/workflows/docker-build.yml/badge.svg)](https://github.com/yurusov/servers-com-test/actions/workflows/docker-build.yml)

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

