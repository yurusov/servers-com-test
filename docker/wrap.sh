#!/bin/sh

set -ex

bundle exec rake db:create
bundle exec rake db:migrate 

bundle exec $@
