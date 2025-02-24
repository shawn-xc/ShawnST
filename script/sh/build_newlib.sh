set + e
#!/bin/bash

# 获取脚本所在位置
SCRIPT_DIR=$(dirname "$(realpath "$0")")
WORKSPACE=$(realpath ${SCRIPT_DIR}/../..)
NEWLIB_DIR=${WORKSPACE}/newlib-3.3.0

# 编译器位置
export PATH=${WORKSPACE}/ShawnLLVM/install/bin:$PATH
export LD_LIBRARY_PATH=${WORKSPACE}/ShawnLLVM/install/lib:$LD_LIBRARY_PATH

#flags for target
flags_for_libc0="-DHAVE_INITFINI_ARRAY -D__LINUX_ERRNO_EXTENSIONS__ -D__OBSOLETE_MATH=0 -D__RSDK_MATH=1 "
flags_for_libc1="-fno-unsafe-math-optimizations -fstack-protector -mcmodel=medlow -fno-short-enums -fno-short-wchar "
flags_for_libc2le="--target=riscv32 -march=rv32im -mabi=ilp32 "
flags_for_ligc3="-O2 -Wno-implicit-int -Wno-implicit-function-declaration -Wno-int-conversion"

# configure parameter
config_para0="--target=riscv32-unknown-elf --prefix=${NEWLIB_DIR}/install "
config_para1="--disable-shared --enable-newlib-io-long-long=yes --enable-newlib-io-long-double=yes "
config_para2="--enable-newlib-io-c99-formats=yes --disable-nls --disable-libssp"
config_para="${config_para0} ${config_para1} ${config_para2}"
echo "${config_para}"

export CC_FOR_TARGET=clang-19 
export CXX_FOR_TARGET=clang-19
export AS_FOR_TARGET=llvm-as 
export AR_FOR_TARGET=llvm-ar 
export LD_FOR_TARGET=ld.lld 
export RANLIB_FOR_TARGET=llvm-ranlib


#littleendian
flags_for_libc="${flags_for_libc0} ${flags_for_libc1} ${flags_for_libc2le} ${flags_for_libc3}"
echo "${flags_for_libc}"


export CFLAGS_FOR_TARGET=${flags_for_libc} 
export CXXFLAGS_FOR_TARGET=${flags_for_libc}

cd ${NEWLIB_DIR}
mkdir -p build && cd build
../configure ${config_para}
make all -j 8
make install 