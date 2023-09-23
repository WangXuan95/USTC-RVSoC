## 简介
这个BSP的架子已经搭起来了，它包含了  
- 启动文件
- 链接脚本
- uart示例固件库
- Makefile编译脚本
- MRS工程文件
- bin转txt的python3脚本


## MRS开发
MRS是沁恒搞的一个Eclipse魔改版RV开发环境，主打Windows系统下开发，我用着挺方便的  
[下载MRS软件](http://www.mounriver.com/)，然后双击打开`BSP/app.wvproj`  
编译生成的文件在`BSP/obj`  


## Makefile开发
理论上Windows和Linux都支持，但我只在win10测试过  

至少需要准备好make，gcc工具链，可以去这里下载：  
https://pan.baidu.com/s/1thofSUOS5Mg0Fu-38qPeag?pwd=dj8b  
https://github.com/xiaowuzxc/SparrowRV/releases/tag/v0.8  
对于Windows系统，需要下载`make.exe`并加入环境变量  

根据系统不同下载gcc工具链，放在以下位置，保持目录结构为以下形式： 
```
USTC-RVSoC
  ├─...
  └─BSP
      ├─...
      └─RISC-V_Embedded_GCC
         ├─bin
         ├─distro-info
         ├─doc
         ├─include
         ├─lib
         ├─libexec
         ├─riscv-none-embed
         └─share
``` 

进入`BSP/app`，输入`make all`编译，输入`make clean`清理文件  

makefile开发有个问题要注意，二进制文件在`BSP/app`文件夹，编译生成的散文件和对应的.c文件在一起  


## Bin转txt
编译生成的是bin文件，无论是仿真还是串口烧录都不方便，所以需要转换成txt文件  
**这一步需要Python3，Python2是不行的**  

进入`BSP/app`，输入`make b2t`，选择要转换的bin文件，转换后会在当前目录生成`inst.txt`  
如果是Linux系统，直接输入python默认启动python2，需要把`BSP/app/makefile`59行`python`改成`python3`  

也可以直接想办法运行`BSP/bin2txt.py`   

## 文件结构
```
BSP
  ├─app 用户程序
  ├─lib 固件库
  | ├─include 头文件
  | ├─src C文件
  | ├─init.c 初始化系统
  | ├─start.S 启动文件
  | └─system.h 系统头文件
  ├─link.lds 链接脚本
  ├─bin2txt.py Bin转txt的python脚本
  ├─其他文件是MRS的工程文件
  └─RISC-V_Embedded_GCC [gcc工具链]
``` 
