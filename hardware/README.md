# USTCRVSoC 硬件

> * ./RTL 目录中是 SoC 全部的 SystemVerilog 代码。
> * ./Quartus 目录中是基于 Altera FPGA 的工程，目前有 DE0-Nano 开发板。
> * ./Vivado 目录中是基于 Xilinx FPGA 的工程，目前有 Arty-7 开发板和 Nexys4 开发板。
> * ./Simulation_SoC 目录是对整个 SoC 的仿真工程
> * ./Simulation_RiscvCPU 目录是对 RiscV-CPU 进行的指令集测试仿真（使用RiscV官方测试）
> * 请注意，所有工程共用 ./RTL 目录，因此在一个工程里修改 SoC 代码也会导致其它工程中的代码发生变化
