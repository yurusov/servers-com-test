#!/bin/sh

set -ex

exec ./wrap.sh hanami server --host 0.0.0.0
