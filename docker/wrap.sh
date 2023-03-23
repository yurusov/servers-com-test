#!/bin/sh

set -ex

(export $(grep -v '^#' .env.$HANAMI_ENV | xargs) && createdb) || true

bundle exec rake db:migrate

bundle exec $@
