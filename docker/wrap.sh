#!/bin/sh

set -ex

bundle exec rake db:create || true
bundle exec rake db:migrate 

bundle exec $@
