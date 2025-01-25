set + e
#!/bin/bash

# 获取脚本所在目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")
WORKSPACE=$(realpath ${SCRIPT_DIR}/../..)
SC_DIR=${WORKSPACE}/systemc-3.0.0

#echo "workspace is ${WORKSPACE}"
#echo "脚本所在路径: $SCRIPT_DIR"

pushd ${SC_DIR} > /dev/null
  if [ ! -d build ]; then
    mkdir build
  fi

  cd build
  install_path=$(realpath ${SC_DIR}/install)
  ../configure --prefix="$install_path"
  make -j 4
  make install
popd > /dev/null
