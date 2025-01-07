# 编译

## 依赖

```bash
sudo apt-get install -y git g++ make libssl-dev libgflags-dev libprotobuf-dev libprotoc-dev protobuf-compiler libleveldb-dev
```

如果你要运行测试，那么需要安装并编译 libgtest-dev（它没有被默认编译）：

```bash
sudo apt-get install -y cmake libgtest-dev && cd /usr/src/gtest && sudo cmake . && sudo make && sudo mv lib/libgtest* /usr/lib/ && cd -
```

gtest 源码目录可能变动，如果 /usr/src/gtest 不存在，请尝试 /usr/src/googletest/googletest。

## config_brpc.sh 编译

```shell
sh config_brpc.sh --headers=/usr/include --libs=/usr/lib
make
```

* 要修改编译器为clang，添加选项`--cxx=clang++ --cc=clang`
* 不想链接调试符号，添加选项`--nodebugsymbols`，然后编译将会得到更轻量的二进制文件
* 使用 glog 版的brpc，添加选项`--with-glog`
* 要启用 thrift 支持，首先需要安装 thrift 并且添加选项 `--with-thrigt`

运行样例：

```bash
cd example/echo_c++
make
./echo_server &
./echo_client
```

## [废弃] Bazel 编译

> Bazel 本身编译比较麻烦，暂不考虑。

安装 bazel:

```bash
# 使用 BAZEL 的 apt 代码库
sudo apt install apt-transport-https curl gnupg -y
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
sudo mv bazel-archive-keyring.gpg /usr/share/keyrings
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list

# 安装和更新 BAZEL
sudo apt update && sudo apt install bazel

# 除了最新版本的 BAZEL 外, 也可以安装特定的旧版本 BAZEL
# sudo apt install bazel 6.1.1

# 查看安装的 BAZEL 版本
bazel --version
```

## CMake 编译

```bash
mkdir build && cd build && cmake .. && cmake --build . -j6
```

对于 cmake 3.13+ 也可以使用如下命令进行编译:

```shell
cmake -B build && cmake --build build -j6
```

* 要帮助VSCode或Emacs(LSP)去正确地理解代码，添加`-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`选项去生成`compile_commands.json`
* 要修改编译器为clang，请修改环境变量`CC`和`CXX`为`clang`和`clang++`
* 不想链接调试符号，请移除`build/CMakeCache.txt`，然后用`-DWITH_DEBUG_SYMBOLS=OFF`选项执行cmake
* 想要让brpc使用glog，用`-DWITH_GLOG=ON`选项执行cmake
* 要启用 thrift 支持，先安装thrift，然后用`-DWITH_THRIFT=ON`选项执行cmake

CMake 运行样例的方式如下：

```bash
cd example/echo_c++
cmake -B build && cmake --build build -j4
./echo_server &
./echo_client
```
