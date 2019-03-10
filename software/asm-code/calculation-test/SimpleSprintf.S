# 概述：实现一个简单的 sprintf 函数，支持 %c %s %u %d 格式化串
#       以 a0 寄存器为目的地址，a1 寄存器为格式字符串地址，a2为起始指针的内存里有待格式化的参数，所有参数以4字节对齐
# Author: WangXuan
# 
# 系统要求：1、具有一个大小至少为0x400 Byte的数据RAM （该程序中，其高地址用作栈，低地址用作被排序的数组）
#           2、测试该代码时，不需要初始化DataRam，只需要将指令流烧入InstrRam。因为有一系列指令去准备被排序的数组。
#           3、请根据实际情况将a0设置为你的DataRam的地址，例如我的SoC DataRam起始地址为0x00010000，则第一条指令就是 lui a0, 0x00010
#


.org 0x0
    .global _start
_start:

main:                          # main函数开始，在DataRam里初始化一段数据
    lui    a0,   0x00020       # 设置DataRam的起始地址为0x00020000，即显存RAM，也用作
    lui    a2,   0x00010
    addi   sp,   a2  , 0x400   # 设置栈顶指针 = 0x00010400
    
    auipc  a1,   0x00000       # 获取当前的PC值，目的是能够推算出以下的.string的起始地址
    jal    zero, AfterString1  # 跳转到以下.string 之后，因为string是一个指令RAM中的数据，不能被执行
    .string  "(a2):%s (a2+4):%c\0"     # 在指令RAM中实现一个string，该string作为sprintf的格式串，在之后调用sprintf时被使用，为了与C语言sprintf一致，显式规定以\0结尾

.align 4    # 下一条指令以4字节对齐
AfterString1:
    addi   a1,   a1, 0x08      # 将a1+8,以得到真正的.string的起始地址

    auipc  a3,   0x00000       # 获取当前的PC值，目的是能够推算出以下的.string的起始地址
    jal    zero, AfterString2  # 跳转到以下.string 之后，因为string是一个指令RAM中的数据，不能被执行
    .string  "hello!\0"     # 在指令RAM中实现另一个string
.align 4    # 下一条指令以4字节对齐
AfterString2:
    addi   a3,   a3  , 0x08      # 将a3+8,以得到真正的.string的起始地址
    
    sw     a3,  (a2)
    ori    a3,  zero, 'a'
    sw     a3, 4(a2)
    jal    ra, SimpleSprintf
infinity_loop:
    jal  zero, infinity_loop     # 死循环

    
SimpleSprintf:
    # 以 a0 寄存器为目的地址，a1 寄存器为格式字符串地址，a2为起始指针的内存里有待格式化的参数，所有参数以4字节对齐
    # 在调用该函数时，需要准备a0，a1两个寄存器，并在栈中从后向前的(cdecl调用顺序) push 参数
    or    t0, zero, zero               # t0 清零
    SimpleSprintfLoopStart:
        or    t1, t0, zero             # 备份t0到t1
        lbu   t0,   (a1)
        sb    t0,   (a0)
        addi  a1,  a1, 1
        addi  a0,  a0, 1
        bne   t0, zero, DontReturn     # 如果没遇到遇到\0，就跳过函数返回
        jalr  zero, ra, 0              # 遇到\0，函数返回
    DontReturn:
        ori   t2, zero, '%'
        bne   t1, t2, SimpleSprintfLoopStart    # 如果t1!='%'，说明还没碰到需要格式化打印的情况，跳到函数开始去循环执行
        
        addi  a0, a0, -1               # 目的字符串指针回退一步，回到%之后
        ori   t2, zero, 'c'
        bne   t0, t2, NotC
        lw    t2, (a2)                 # 从a2地址中获得一个参数
        addi  a2, a2, 4
        sb    t2, -1(a0)               # 向目标字符串中写入
        jal   zero, SimpleSprintfLoopStart

    NotC:
        ori   t2, zero, 's'
        bne   t0, t2, NotS
        lw    t2, (a2)                 # 从a2地址中获得一个参数
        addi  a2, a2, 4
        StringCopystart:
            lbu   t3, (t2)
            beq   t3, zero, SimpleSprintfLoopStart
            addi  t2, t2, 1
            sb    t3, -1(a0)
            addi  a0, a0, 1
            jal   zero, StringCopystart
        
    NotS:
        ori   t2, zero, 'd'
        bne   t0, t2, NotD
        lw    t2, (a2)                 # 从a2地址中获得一个参数
        addi  a2, a2, 4
        jal   zero, SimpleSprintfLoopStart

    NotD:
        ori   t2, zero, 'u'
        bne   t0, t2, NotU
        lw    t2, (a2)                 # 从a2地址中获得一个参数
        addi  a2, a2, 4
        jal   zero, SimpleSprintfLoopStart

    NotU:
        ori   t2, zero, 'x'
        bne   t0, t2, SimpleSprintfLoopStart
        lw    t2, (a2)                 # 从a2地址中获得一个参数
        addi  a2, a2, 4
        jal   zero, SimpleSprintfLoopStart
    
    
    
    
    
    
    