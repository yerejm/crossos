#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

export SRCDIR=build
export HAVE_RULES=yes
export CXXFLAGS="-O2 -DNDEBUG -Wall -Wno-sign-compare -Wno-unused-function"
export PREFIX=/usr/local/cppcheck
export CFGDIR=${PREFIX}/cfg

RELEASE=1.76.1
GITREPO=https://github.com/danmar/cppcheck.git
git clone --recursive --depth 1 -b ${RELEASE} ${GITREPO} && \
    (cd cppcheck && \
    make -j4 && \
    make install)
