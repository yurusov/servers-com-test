#!/bin/sh

set -ex

createdb || true
bundle exec rake db:migrate

bundle exec $@
