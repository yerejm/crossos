#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

LLVM=https://llvm.org/svn/llvm-project/llvm/tags/RELEASE_381/final/
CLANG=https://llvm.org/svn/llvm-project/cfe/tags/RELEASE_381/final/
COMPILER_RT=https://llvm.org/svn/llvm-project/compiler-rt/tags/RELEASE_381/final/
EXTRA=https://llvm.org/svn/llvm-project/clang-tools-extra/tags/RELEASE_381/final/
mkdir -p scanbuild && \
    (cd scanbuild && \
        (svn export ${LLVM} llvm && \
            (cd llvm/tools && svn export ${CLANG} clang) && \
            (cd llvm/tools/clang/tools && svn export ${EXTRA} extra) && \
            (cd llvm/projects && svn export ${COMPILER_RT} compiler-rt)) && \
        (cmake -Hllvm -Bbuild && cd build && make -j2 && make install))

