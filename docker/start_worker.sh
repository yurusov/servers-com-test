#!/bin/sh

set -ex

exec /app/docker/wrap.sh ruby lib/ping_worker.rb
