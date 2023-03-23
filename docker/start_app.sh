#!/bin/sh

set -ex

exec /app/docker/wrap.sh hanami server --host 0.0.0.0
