SCRIPT_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
WORKSPACE=$(realpath ${SCRIPT_DIR}/..)

echo ${WORKSPACE}


# check LLVM, SPIKE
clang_install=${WORKSPACE}/ShawnLLVM/install
spike_install=${WORKSPACE}/spike/install


if [ ! -d ${clang_install} ]; then
    echo "error! ${clang_install} does NOT exist. "
    exit 1
fi

if [ ! -d ${spike_install} ]; then
    echo "error! ${spike_install} does NOT exist. "
    exit 1
fi

#echo ${SCRIPT_DIR} ${WORKSPACE}

alias clang-xiao=${clang_install}/bin/clang
alias spike-xiao=${spike_install}/bin/spike