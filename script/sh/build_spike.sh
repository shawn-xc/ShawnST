set + e
#!/bin/bash

# 获取脚本所在目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")
WORKSPACE=$(realpath ${SCRIPT_DIR}/../..)
SPIKE_DIR=${WORKSPACE}/spike

# 大小端编译参数
install_endian=("be", "le")
enable_endian=("--enable-dual-endian" " ")

pushd ${SPIKE_DIR} > /dev/null
  if [ ! -d build ]; then
    mkdir build
  fi

  cd build
  install_path=$(realpath ${SPIKE_DIR}/install)
  ../configure --prefix="$install_path"
  make -j 4
  make install
popd > /dev/null



############# 编译参数  #######


