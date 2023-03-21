#!/bin/sh

set -ex

PGPASSWORD=$DATABASE_PASSWORD createdb -h $DATABASE_HOST -p $DATABASE_PORT -U $DATABASE_USER -w $DATABASE_NAME || true
bundle exec rake db:migrate

bundle exec $@
