#!/bin/bash

# This script downloads Cmake, LLVM and Clang and installs it to the correct paths
TOOLS_DIR = "$1"
LOCAL_DIR = "$2"

if [!-d "$TOOLS_DIR"]
then
    mkdir -p $TOOLS_DIR
else
    echo "$TOOLS_DIR already exists, skipping"
fi

if [!-d "$LOCAL_DIR"]
then
    mkdir -p $LOCAL_DIR
    mkdir -p $LOCAL_DIR/bin
else
    echo "$LOCAL_DIR already exists, skipping"
fi

# Add local to path
export PATH = ~/.local:~/.local/bin:$PATH

if [!"$(ls -A $TOOLS_DIR/CMake)"]
then
    cd $TOOLS_DIR

    git clone https://github.com/Kitware/CMake.git
    # Install CMake
    cd CMake
    ./bootstrap --prefix=$LOCAL_DIR &&  make && make install
else
    echo "$TOOLS_DIR is not empty - skipping Cmake installation"
fi

if [!"$(ls -A $TOOLS_DIR/llvm)"]
then
    cd $TOOLS_DIR
    #Get LLVM/CLANG
    git clone https://github.com/llvm-mirror/llvm.git
    cd llvm/tools/
    git clone https://github.com/llvm-mirror/clang.git
    cd $TOOLS_DIR/llvm/projects
    git clone https://github.com/llvm-mirror/compiler-rt.git
    # Install LLVM/CLANG
    cd $TOOLS_DIR/llvm/
    mkdir build
    cd build
    # Configure and build (Using defualt build, eg gcc)
    cmake -DCMAKE_INSTALL_PREFIX=$LOCAL_DIR ../
    cmake --build .
    # Install
    cmake --build . target --install

    # Install / Compile ycm
    #cmake -G Unix Makefiles -DEXTERNAL_LIBCLANG_PATH=$LOCAL_DIR/lib/libclang.so -DPATH_TO_LLVM_ROOT=$LOCAL_DIR . ../third_party/ycmd/cpp/
    #cmake --build . --target ycm_support_libs --config Release
else
    echo "$TOOLS_DIR/llvm is not empty. Skipping llvm installation"
fi

