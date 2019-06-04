#!/bin/bash

set -e

. ci/travis/lib.sh

build_default() {
    pushd "${TRAVIS_BUILD_DIR}"
    cd build
    sudo make -j${NUM_JOBS}
    popd
}

build_cppcheck() {
    check_cppcheck
}

build_clang_format() {
    check_clangformat
}

build_deploy_doxygen() {
    pushd "${TRAVIS_BUILD_DIR}/doc"
    mkdir build && cd build && cmake .. 
    check_doxygen
    deploy_doxygen
}

build_${BUILD_TYPE:-default}