#!/usr/bin/env bash

set -e

PROJECT_DIR=$(pwd)

# build using make
build_default() {
    cd "$PROJECT_DIR"
    mkdir -p ./build/default
    cd "$PROJECT_DIR/build/default"
    cmake ../..
    make
}

# build using ninja
build_ninja() {
    cd "$PROJECT_DIR"
    mkdir -p ./build/ninja
    cd "$PROJECT_DIR/build/ninja"
    cmake -GNinja ../..
    ninja
}

build_default

exit 0
