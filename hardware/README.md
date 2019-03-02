# USTCRVSoC 硬件

> * ./RTL 目录中是 SoC 全部的 SystemVerilog 代码。
> * ./Quartus 目录中是基于 Altera FPGA 的工程，目前只有 DE0-Nano 开发板。
> * ./Vivado 目录中是基于 Xilinx FPGA 的工程，目前只有 Nexys4 开发板。
> * ./ModelSim 目录是基于 ModelSim 的仿真工程。
> * 请注意，后三者的工程共用 ./RTL 目录，因此在一个工程里修改 SoC 代码也会导致其它工程中的代码发生变化
