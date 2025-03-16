clang -O2 $spikeLinder/syscalls.c ${defaultLink} -- target=riscv32  --sysroot=$SNPLibLE -fno-builtin-printf -fno-unroll-loops -fno-inline-functions -finline-hint-functions -DPREALLOCATE=1 -static -std=gnu99 -$$SNPInclude - L$SNPLibLe/gcc/rv32im/ilp32 -fuuse-ld=lld -lgcc -DEBUG


error:

/mnt/e/linux/ShawnST/spike/linker/syscall.c:9:10: fatal error: 'util.h' file not found
    9 | #include "util.h"
      |          ^~~~~~~~
1 error generated.
terminate called after throwing an instance of 'std::logic_error'
  what():  basic_string::_M_construct null not valid
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace, preprocessed source, and associated run script.
Stack dump:
0.      Program arguments: /mnt/e/linux/ShawnST/ShawnLLVM/install/bin/clang-19 -cc1 -triple riscv32 -emit-obj -dumpdir hello.bin- -disable-free -clear-ast-before-backend -main-file-name hello.c -static-define -mrelocation-model static -mframe-pointer=none -fmath-errno -ffp-contract=on -fno-rounding-math -mconstructor-aliases -nostdsysteminc -target-cpu generic-rv32 -target-feature +m -target-feature +a -target-feature +c -target-feature +zmmul -target-feature -b -target-feature -d -target-feature -e -target-feature -f -target-feature -h -target-feature -shc