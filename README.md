# USTCRVSoC

一个用SystemVerilog编写的，基于RISC-V的SoC

# 特点

> * 5段流水线RISC-V，能运行RV32I指令集
> * 简单直观的32bit握手总线 (naive_bus.sv)，
> * 总线仲裁器(naive_bus_router.sv)可修改，以方便拓展外设、多核、DMA等
> * 具有交互式UART调试器(isp_uart.sv)，用户可以使用PC上的串口助手、minicom等软件，实现系统复位、上传程序、查看内存等功能
> * 全部使用SystemVerilog实现，不调用IP核，方便在Altera、Xilinx、Lattice等不同FPGA平台上移植
> * RAM符合一定的Verilog写法，自动综合成Block RAM

# SoC 结构

![Image text](https://github.com/WangXuan95/USTCRVSoC/blob/master/images/SoC.png)

上图展示了SoC的结构，总线仲裁器bus_router为SoC的中心，上面挂载了2个“主设备”和5个“从设备”。实际上，CPU具有两个“主接口”，因此bus_router共有3个“主接口”和5个“从接口”。

这个SoC使用的总线并不来自于任何标准（例如AXI或APB总线），而是笔者自编的，因为简单所以命名为“naive_bus”。

每个“从接口”都占有一段地址空间。当“主接口”访问总线时，bus_router判断该地址属于哪个地址空间，然后将它“路由”到相应的“从接口”。下表展示了5个“从接口”的地址空间。

| 外设类型 | 起始地址   | 结束地址   | 
| :-----:  | :-----:    | :----:     |
| 指令ROM  | 0x00000000 | 0x00007fff |
| 指令RAM  | 0x00008000 | 0x00008fff |
| 数据RAM  | 0x00010000 | 0x00010fff |
| 显存RAM  | 0x00020000 | 0x00020fff |
| 用户UART | 0x00030000 | 0x00030003 |

### 主要部件

> * **多主多从总线仲裁器(naive_bus_router.sv)**：为每个从设备划分地址空间，将主设备的总线读写请求路由到从设备。当多个主设备同时访问一个从设备时，还能进行访问冲突控制。
> * **RV32I Core(core_top.sv)**：包括两个主接口。一个用于取指令，一个用于读写数据
> * **UART调试器(isp_uart.sv)**：包括一个主接口和一个从接口。它接收用户从UART发来的命令，对总线进行读写。它可以用于在线烧写、在线调试。也可以接收CPU的命令去发送数据。
> * **指令ROM(instr_rom.sv)**：CPU默认从这里开始取指令，多用于仿真
> * **指令RAM(ram_bus_wrapper.sv)**：用户在线烧写程序到这里。
> * **数据RAM(ram_bus_wrapper.sv)**：存放运行时的数据。
> * **显存RAM(vedio_ram.sv)**：在屏幕上显示98列*36行=3528个字符，显存RAM的前3528B对应的ASCII码值就决定了每个字符是什么

# RV32I CPU 结构

![Image text](https://github.com/WangXuan95/USTCRVSoC/blob/master/images/Core-RTL.png)

TODO

# 在开发板上运行SoC

我们提供了两种方式运行代码：

1、**使用指令ROM**：修改instr_rom.sv中的代码，然后重新编译综合，重新烧写FPGA逻辑。虽然麻烦，但这便于进行RTL仿真，你可以将想要运行的程序放入指令ROM，然后仅需在testbench中给予SoC一个时钟，就可以观察整个SoC在运行这段代码时的波形。

2、**使用指令RAM**：使用UART调试器在线上传程序到指令RAM。

### 部署电路到FPGA

目前，我们提供了Xilinx的Nexys4板子和Altera的DE0-Nano板子的工程。

1、**Nexys4硬件连接**：Nexys4开发板上有一个USB口既可以用于FPGA烧录，也可以用于UART通信，我们需要连接该USB口到电脑。另外，VGA的连接是可选的，你可以把它连接到屏幕上。

![Image text](https://github.com/WangXuan95/USTCRVSoC/blob/master/images/DE0-Nano.png)

2、**DE0-Nano硬件连接**：DE0-Nano开发板上既没有串口转USB，也没有VGA接口。因此都需要以来外部模块。我们使用DE0-Nano上的两排GPIO作为外接模块的引脚，接口意义如上图。你至少需要一个USB转UART的模块，将ISP-UART的TX和RX引脚连接上去，使之能与电脑通信，如下图：

![Image text](https://github.com/WangXuan95/USTCRVSoC/blob/master/images/connection.png)

![Image text](https://github.com/WangXuan95/USTCRVSoC/blob/master/images/usb_uart.png)

3、**综合、烧写FPGA**：如果你用的是Nexys4板子，请用Vivado打开./hardware/Vivado/nexys4/USTCRVSoC-nexys4/USTCRVSoC-nexys4.xpr。如果你用的是DE0-Nano板子，请用Quartus打开./hardware/Quartus/DE0_Nano/DE0_Nano.qpf。综合并烧写到开发板。

4、**HelloWorld**：烧录FPGA后，在电脑上的串口终端软件（超级终端、串口助手、minicom）中，使用格式(115200,n,8,1)打开串口，如果看到不断收到"hello\n"，那么恭喜你SoC部署成功，因为SoC的instr_rom里的程序就是循环打印hello的程序。

5、**尝试读取总线**：下面让我们尝试UART的调试功能，首先发送"s\n"进入调试模式，可以看到对方发来"debug\n"，说明进入调试模式成功。然后，发送"00000000\n"，会看到对方发来一个8位16进制数。该数代表SoC数据总线的地址0x00000000处的读取数据。

6、上一步我们尝试了UART调试器的读总线命令，下表显示了它的所有3种命令。

![Image text](https://github.com/WangXuan95/USTCRVSoC/blob/master/images/commands.png)

> * 注意：无论是发送还是接受，所有命令都以\n或\r或\r\n结尾

根据这些命令，不难猜出，在线上传程序的流程是：

> 1、使用写命令，将指令流写入指令RAM，（指令RAM的地址是00008000~00008fff）

> 2、使用复位命令r00008000，将CPU复位并从指令RAM中BOOT

### 使用工具：USTCRVSoC-tool  （该软件有所改动，文档稍后补充）

./USTCRVSoC-tool/USTCRVSoC-tool.exe 是一个能汇编和烧写的小工具，相当于一个汇编语言的IDE。

我们提供了几个汇编小程序如下表。

| 文件名   | 说明   |
| :-----  | :-----    |
| uart_print.S  | 用户UART循环打印hello! |
| vga_hello.S   | 屏幕上显示hello！    |
| fibonacci_recursive.S  | 递归法计算斐波那契数列第7个数并，用用户UART打印结果  |
| load_store.S  | 完成一些内存读写，没有具体表现，为了观察现象，可以使用UART调试器查看内存 |

现在我们尝试让SoC运行一个计算斐波那契数列并UART打印的程序。点击“打开...”按钮，浏览到目录./software/asm-code，打开汇编文件 fibonacci_recursive.S。点击右侧的“汇编”按钮，可以看到右方框里出现了一串16进制数，这就是汇编得到的机器码。然后，选择正确的COM口，点击“烧写”，如果下方状态栏里显示“烧写成功”，则CPU就已经开始运行该机器码了。这时，在右侧的“串口查看”框里选中“16进制显示”，可以看到不断显示出15，这说明CPU正确的计算出斐波那契数列的第七个数是0x15，即十进制的21。



# RTL仿真

### 生成Verilog ROM

USTCRVSoC-tool.exe 除了进行烧写，也可以生成指令ROM的Verilog代码。当你使用“汇编”按钮产生指令流后，可以点击右侧的“保存指令流(Verilog)”按钮，用生成的ROM代码替换 ./RTL/instr_rom.sv

### 进行仿真

生成ROM后请直接使用soc_top_tb.sv文件进行仿真，这个仿真是针对整个SoC的，因此你可以修改ROM程序后进行仿真，观察SoC运行该程序的行为。


