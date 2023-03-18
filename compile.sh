#!/usr/bin/env bash
# see https://llvm.org/docs/CMake.html for build options

# setup dirs
mkdir -p build
mkdir -p install

# cleanup build
rm -rf build/*

# run generate
cmake -S llvm-project/llvm -B build -G "Unix Makefiles" \
    -DCMAKE_INSTALL_PREFIX=./install \
    -DLLVM_ENABLE_PROJECTS="clang" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DLLVM_USE_LINKER=lld \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_FLAGS="-O3" \
    -DCMAKE_C_FLAGS="-O3"

# build with all but 2 cores
cmake --build build -j$(nproc --ignore 2)

# install
pushd build
    make install
popd

