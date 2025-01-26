set + e
#!/bin/bash

# 获取脚本所在目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")
WORKSPACE=$(realpath ${SCRIPT_DIR}/../..)
SPIKE_DIR=${WORKSPACE}/spike


pushd ${SPIKE_DIR} > /dev/null
  if [ -d build ]; then
    rm -rf build
  fi

  if [ -d install ]; then
    rm -rf install
  fi
  
popd > /dev/null



############# 编译参数  #######


