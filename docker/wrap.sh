#!/bin/sh

set -ex

createdb -h $DATABASE_HOST -p $DATABASE_PORT -U $DATABASE_USER -W $DATABASE_PASSWORD $DATABASE_NAME || true
bundle exec rake db:migrate

bundle exec $@
