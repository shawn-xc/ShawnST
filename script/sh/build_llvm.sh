set + e
#!/bin/bash

# 获取脚本所在目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")
WORKSPACE=$(realpath ${SCRIPT_DIR}/../..)
LLVM_DIR=${WORKSPACE}/ShawnLLVM


# others cmake parameter
cmake_para="-DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=../install -DLLVM_BUILD_TOOLS=ON -DLLVM_BUILD_TESTS=ON -DLLVM_ABI_BREAKING_CHECKS=WITH_ASSERTS"

# start compiling
pushd ${LLVM_DIR} > /dev/null
  if [ ! -d build ]; then
    mkdir build
    cd build
     
    #cmake ../llvm ${cmake_para} -DLLVM_TARGET_TO_BUILD="RISCV" -DLLVM_ENABLE_PROJECTS="clang"
    cmake ../llvm ${cmake_para} -DLLVM_TARGET_TO_BUILD="RISCV" -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld"
  else
    cd build
  fi

  make -j 10
  make install
popd > /dev/null

