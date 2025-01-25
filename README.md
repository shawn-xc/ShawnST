# ShawnST
## 1 写在开始的话
一个简单的自我测试集合，包含LLVM编译器、SPIKE仿真器、SystemC 模型，开展一些RV的探索。

## 2 工程编译
### SPIKE仿真器
参考spike中的readme即可完成相关的编译参数设置，关键步骤包括:
* 安装依赖库
  ```bash
  apt-get install device-tree-compiler libboost-regex-dev libboost-system-dev
  ```
* 执行spike工程编译
  ```bash
  make simulator
  ```

### SystemC库
参考systemc中的INSTALL即可完成相关编译参数设置，编译时可能遇到类似 ` No rule to make target 'README.txt', needed by 'all-am'`的错误，直接在makefile.in中将对应的`README.txt`编译内容删除即可，不影响。
```bash
#systemc工程编译
make systemc
```

