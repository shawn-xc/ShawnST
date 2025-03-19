clang-le-link hello.c -o hello.elf

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
clang-19 --target=riscv32 -emit-llvm hello.c -S -o hello.ir -I$librv32le/include
te called after throwing an instance of 'std::logic_error'
  what():  basic_string::_M_construct null not valid
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace, preprocessed source, and associated run script.
Stack dump:
0.      Program arguments: clang-19 --target=riscv32 -emit-llvm hello.c -S -o hello.ir -I/mnt/e/linux/ShawnST/riscv32/riscv32-unknown-elf/include
1.      <eof> parser at end of file
^C