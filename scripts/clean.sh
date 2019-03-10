#!/usr/bin/env bash

set -e

PROJECT_DIR=$(dirname "$0")
echo "$PROJECT_DIR"

# workaround
PROJECT_DIR=/home/phantomape/Projects/rocksdb-server
echo "$PROJECT_DIR"

rm -rf "$PROJECT_DIR/build"

exit 0
