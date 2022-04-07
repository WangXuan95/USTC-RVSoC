# 概述：判断系统的存储结构是大端序还是小端序
#       如果为大端序则t0寄存器置 0x00000001，且DataRam第五个字节置0x01
#       如果为小端序则t0寄存器置 0x00000002，且DataRam第五个字节置0x02
# Author: WangXuan
#
#
# 
# 系统要求：1、具有一个数据RAM （该程序中，其高地址用作栈）
#           2、请根据实际情况将a0设置为你的DataRam的地址，例如我的SoC DataRam起始地址为0x00010000，则我第一个指令是lui sp, 0x00010
#


.org 0x0
    .global _start
_start:
    
    lui    a0, 0x00010
    lui    t1, 0x01000
    ori    t1, t1, 0x002
    sw     t1, (a0)
    lb     t0, (a0)
    sb     t0, 5(a0)

here:
    jal    zero, here     # 死循环
    
            