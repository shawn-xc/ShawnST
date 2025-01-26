set + e
#!/bin/bash

# 获取脚本所在目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")
WORKSPACE=$(realpath ${SCRIPT_DIR}/../..)
LLVM_DIR=${WORKSPACE}/ShawnLLVM


pushd ${LLVM_DIR} > /dev/null
  if [ -d build ]; then
    rm -rf build
  fi

  if [ -d install ]; then
    rm -rf install
  fi
  
popd > /dev/null



############# 编译参数  #######


