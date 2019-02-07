# USTCRVSoC

一个用SystemVerilog编写的，基于RISC-V的SoC

# 特点

1、RISC-V核采用5段流水线，能运行RV32I指令集

2、SoC使用简单直观的32bit握手总线(naive_bus.sv)，

3、总线仲裁器(naive_bus_router.sv)预留了宏，可修改主从设备的数量和地址空间，以方便拓展外设、多核、DMA等

4、具有UART调试器(isp_uart.sv)，用户可以使用PC上的串口助手、minicom等软件，实现交互式的系统复位、上传程序、查看内存等功能

5、全部使用SystemVerilog实现，不调用IP核，方便在Altera、Xilinx、Lattice等不同FPGA平台上移植

6、RAM和ROM符合一定的Verilog写法，自动综合成Block RAM

# SoC 结构

![Image text](https://github.com/WangXuan95/USTCRVSoC/blob/master/SoC.png)

主要部件包括：

1、多主多从总线仲裁器(naive_bus_router.sv)：负责接受主接口发来的读写请求，根据其地址空间将其路由到相应的从接口，并在不同主接口同时访问一个从接口时，控制其中优先级高的从接口先进行访问，优先级低的主接口等待。

2、RV32I Core(core_top.sv)：包括两个主接口，一个用于取指令，一个用于读写数据

3、UART调试器(isp_uart.sv)：包括一个主接口。它接收用户从UART发来的命令，操控复位等信号，或对总线进行读写。可以使用UART命令复位整个SoC，上传程序，或者查看运行时的RAM数据。

4、指令ROM(instr_rom.sv)：地址空间00000000~00000fff，CPU复位后从00000000开始取指令，因此若在指令ROM中存放编译好的指令流，复位后就自动运行其中的程序

5、数据RAM(ram_bus_wrapper.sv)：地址空间00010000~00010fff

6、显存RAM(vedio_ram.sv)：地址空间00020000~00020fff，一共4096B，若VGA信号正确连接到VGA接口，则屏幕上能够显示98列*36行=3528个字符，显存RAM的前3528B对应的ASCII码值就决定了每个字符是什么

7、用户UART(user_uart_tx)：暂时只具有发送功能，地址空间00030000~00030003，向00030000写一个字节相当于把该字节放入发送缓冲区FIFO，缓冲区大小256B，缓冲区的数据会尽快发送。
       
# 修改ROM程序

目前我只尝试了将汇编语言汇编成该CPU的目标指令并运行，方法是：

1、将汇编代码汇编为指令流并存在Verilog ROM中：在./ASM目录中运行python文件：asm2verilogrom.py，具体命令行命令格式见python中的注释。推荐使用windows完成这一步，因为 ./ASM/riscv32-gnu-toolchain-windows 中提供了编译好的riscv-windows工具链，不需要另外配置环境。

2、将生成的.sv文件中的内容复制，替换 ./RTL/instr_rom.sv 中的内容。

# RTL仿真

请直接使用soc_top_tb.sv文件进行仿真，这个仿真是针对整个SoC的，因此你可以修改ROM程序后进行仿真，观察SoC运行该程序的行为
