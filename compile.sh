#!/usr/bin/env bash
# see https://llvm.org/docs/CMake.html for build options

# setup dirs
mkdir -p build
mkdir -p install

# run generate
cmake -S llvm-project/llvm -B build -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=./install -DLLVM_ENABLE_PROJECTS="clang" -DCMAKE_BUILD_TYPE=Debug -DLLVM_USE_LINKER=lld
#cmake -S llvm-project/llvm -B build -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=./install -DCMAKE_BUILD_TYPE=Debug

# to run all regression tests
#cmake --build build check-all

# for sub projects
#cmake --build build check-project

# build with all but 2 cores
cmake --build build -j$(nproc --ignore 2)

# install
pushd build
make install
popd

