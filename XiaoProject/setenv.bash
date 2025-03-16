SCRIPT_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
WORKSPACE=$(realpath ${SCRIPT_DIR}/..)

echo ${WORKSPACE}

# newlib libary
librv32le=${WORKSPACE}/riscv32/riscv32-unknown-elf
librv32be=${WORKSPACE}/riscv32be

# check LLVM, SPIKE
clang_install=${WORKSPACE}/ShawnLLVM/install
spike_install=${WORKSPACE}/spike/install

#echo ${clang_install}

# linker syscall
linkPath=${WORKSPACE}/spike/linker

# check path
if [ ! -d ${clang_install} ]; then
    echo "error! ${clang_install} does NOT exist. "
    exit 1
fi

if [ ! -d ${spike_install} ]; then
    echo "error! ${spike_install} does NOT exist. "
    exit 1
fi

#echo ${SCRIPT_DIR} ${WORKSPACE}
export PATH=${clang_install}/bin:${spike_install}/bin:$PATH
#echo $PATH

spikeLinker="$linkPath/crt.S -T $linkPath/test.ld"


alias clang-xiao=${clang_install}/bin/clang
alias spike-xiao=${spike_install}/bin/spike

alias clang-le-link="clang-19 -O2 $linkPath/syscall.c $spikeLinker --target=riscv32 --sysroot=$librv32le -fno-builtin-printf -fno-unroll-loops -fno-inline-functions -finline-hint-functions -DPREALLOCATE=1 -static -std=gnu99 -I$librv32le/include -Lgcc/riscvim/ilp32 -fuse-ld=lld -lgcc -DDEBUG"