---
title: cmake创建动态库和引用动态库
tags: [cmake, environment]
date: "2018-3-20"
---

CLion默认使用Cmake作为工程构建工具，使用CLion还得先学这个吗……
# 学习教程
[Cmake实践](http://sewm.pku.edu.cn/src/paradise/reference/CMake%20Practice.pdf)

[Quick Cmake Tutorial](https://www.jetbrains.com/help/clion/quick-cmake-tutorial.html)

Cmake实践的介绍比较详细，但是我即使照着一步步做还是炸了。
## 坑点
在t4编译成功之后无法运行`./src/main`，报错:
`error while loading shred libraries: libhello.so.1: cannot open shared objedct file: No such file or directory
`
<!--more-->

## 解决办法
运行`sudo ldconfig`重新建立链接，原因暂时还没想懂，莫非系统缓存了所有动态链接库？

# 创建动态库工程（外部构建）
1. 创建`lib`目录和`build`目录
2. 主文件夹下写工程文件`CMakeLists.txt`如下：
```
PROJECT(HELLOLIB)
ADD_SUBDIRECTORY(lib)
```
3. `lib`文件夹下写文件`hello.c` 和`hello.h`，具体自己想
4. `lib`文件夹下写工程文件`CMakeLists.txt`：
```
SET(LIBHELLO_SRC hello.c)
#分别生成动态库和静态库
ADD_LIBRARY(hello SHARED ${LIBHELLO_SRC})
ADD_LIBRARY(hello_static STATIC ${LIBHELLO_SRC})

#重命名hello_static 为hello，统一输出文件的名字
SET_TARGET_PROPERTIES(hello_static PROPERTIES OUTPUT_NAME "hello")

#设置版本号
SET_TARGET_PROPERITES(hello PROPERTIES VERSION 1.2 SOVERSION 1)

#配置install
#LIBRARY DESTINATION 为动态库
#ARCHIVE DESTINATION 为静态库
INSTALL(TARGETS hello hello_static
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)
INSTALL(FILES hello.h DESTINATION include/hello)
```
5. 在`build`文件夹下`cmake ..`生成makefiles，然后`make`+`make install`安装

# 在工程中引用自己的动态库
1. 创建工程文件夹，`src`目录和`build`目录
2. 主文件夹下写工程文件`CMakeLists.txt`如下：
```
PROJECT(HELLOLIB)
ADD_SUBDIRECTORY(src)
```
3. `src`文件夹写文件`main.c`
4. `src`文件夹下写工程文件`CMakeLists.txt`：
```
INCLUDE_DIRECTORIES(/usr/include/hello)
ADD_EXECUTABLE(main main.c)
FIND_PATH(myHeader hello.h)
IF(myHeader)
INCLUDE_DIRECTORIES(${myHeader})
ENDIF(myHeader)
TARGET_LINK_LIBRARIES(main hello)
```


# 基本语句格式

PROJECT(projectname [CXX] [C] [Java])


SET(VAR [VALUE] [CACHE TYPE DOCSTRING [FORCE]])


MESSAGE([SEND_ERROR|STATUS|FATAL_ERROR] "message to display" ...)


**变量使用${}方式取值，但是在IF控制语句中是直接使用变量名**

ADD_SUBDIRECTORY(source_dir [binary_dir] [EXCLUDE_FROM_ALL])

