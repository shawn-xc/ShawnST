clang-le-link hello.c -o hello.elf

clang-19 -O2 $linkPath/syscall.c $spikeLinker --target=riscv32 --sysroot=$librv32le -fno-builtin-printf -fno-unroll-loops -fno-inline-functions -finline-hint-functions -DPREALLOCATE=1 -static -std=gnu99 -I$librv32le/include -Lgcc/riscvim/ilp32 -fuse-ld=lld -lgcc -DDEBUG
syscall.c error:
syscall.c:398:5: error: redefinition of label 'unsigned_number'
  398 |     unsigned_number:



  /mnt/e/linux/ShawnST/spike/linker/syscall.c:138:7: error: expected 'volatile', 'inline', 'goto', or '('
  138 |   asm valatile("mv %0, tp"
      |       ^
/mnt/e/linux/ShawnST/spike/linker/syscall.c:398:5: error: redefinition of label 'unsigned_number'
  398 |     unsigned_number:
      |     ^
/mnt/e/linux/ShawnST/spike/linker/syscall.c:390:5: note: previous definition is here
  390 |     unsigned_number:
      |     ^
/mnt/e/linux/ShawnST/spike/linker/syscall.c:400:5: error: redefinition of label 'signed_number'
  400 |     signed_number:
      |     ^
/mnt/e/linux/ShawnST/spike/linker/syscall.c:392:5: note: previous definition is here
  392 |     signed_number:
      |     ^
/mnt/e/linux/ShawnST/spike/linker/syscall.c:436:3: error: function definition is not allowed here
  436 |   {
      |   ^
/mnt/e/linux/ShawnST/spike/linker/syscall.c:442:13: error: use of undeclared identifier 'sprintf_putch'
  442 |   vprintfmt(sprintf_putch, (void**)&str, fmt, ap);
      |             ^
/mnt/e/linux/ShawnST/spike/linker/syscall.c:543:48: error: use of undeclared identifier 'CONFIG_STRING_ADDR'
  543 |   const char* config_string = *((const char**) CONFIG_STRING_ADDR);
      |                                                ^
/mnt/e/linux/ShawnST/spike/linker/syscall.c:545:10: error: call to undeclared function 'amf_ntiles'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  545 |   return amf_ntiles(config_string);
      |          ^




直接编译IR也报错：
最新报错：
/mnt/e/linux/ShawnST/ShawnLLVM/build/bin/clang-19 --target=riscv32 hello.c $linkPath/syscall.c --sysroot=$librv32le $spikeLinker -O2 -o hello.elf  -fno-builtin-printf -fno-unroll-loops -fno-inline-functions -finline-hint-functions -DPREALLOCATE=1 -static -std=gnu99 -I$librv32le/include -Lgcc/riscvim/ilp32 -fuse-ld=lld -lgcc -DDEBUG
ld.lld: error: unable to find library -lgcc
ld.lld: error: cannot open /mnt/e/linux/ShawnST/ShawnLLVM/build/lib/clang/19/lib/riscv32/libclang_rt.builtins.a: No such file or directory
clang-19: error: ld.lld command failed with exit code 1 (use -v to see invocation)
