# flutter_shop

A new Flutter project.

## Getting Started

一款商城类实战app项目，最主要的是购物车功能的实现。

## 1.让项目运行起来
 mac 环境
### 下载Flutter SDK包
 网址：https://flutter.io/setup-macos/
 ### 配置环境变量
 压缩包下载好以后，找个位置进行解压。这个位置很重要，因为下面配置环境变量的时候要用到。比如你配置到了根目录下的app文件夹。
 ### 1.打开终端工具，使用vim进行配置环境变量，命令如下
 
 vim ~/.bash_profile
 ### 2. 在打开的文件里增加一行代码，意思是配置flutter命令在任何地方都可以使用
 export PATH=/app/flutter/bin:$PATH
 
 提示：这行命令你要根据你把压缩包解压的位置来进行编写，写的是你的路径，很有可能不跟文章一样。
 
 配置完成后，需要用source命令重新加载一下 ，具体命令如下：
 
 source ~/.bash_profile
 
 完成这部以后，就算我们flutter的安装工作完成了，但是这还不能进行开发。可以使用命令来检测一下，是否安装完成了
 
 flutter -h
 
 flutter doctor
 
 ## 2.知识点讲解
 
 
