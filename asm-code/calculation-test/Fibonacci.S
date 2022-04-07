# 概述：递归计算斐波那契数列的第n个数
# Author: WangXuan
# 
# 系统要求：1、具有一个大小至少为0x400 Byte的数据RAM （该程序中，其高地址用作栈）
#           2、请根据实际情况将a0设置为你的DataRam的地址，例如我的SoC DataRam起始地址为0x00010000，则我第一个指令是lui sp, 0x00010
#



.org 0x0
 	.global _start
_start:
    lui   a0, 0x00010   # 设置DataRam的起始地址为0x00010000，也用作被排序数组的起始地址是，即DataRam的起始地址
    addi  sp, a0, 0x400 # 为栈分配0x400Byte的空间
    
    or    t0, zero, 8   # t0 = 8
    jal   ra, Fibonacci # 计算 fib(8) = 34 = 0x22
    sw    t1, (a0)      # 计算结果放在DataRam的首地址
    
infinity_loop:
    jal    zero, infinity_loop # 排序结束，死循环

    
    
Fibonacci:              # 递归计算斐波那契数列的第n项，
                        # n放在t0寄存器中
                        # 结果放在t1寄存器中
                        # 使用ra作为返回地址，并使用堆栈，堆栈指针为sp
    
    ori   t4, zero, 3   # t4 = 3
    bgeu  t0, t4, tag   # if t0>=t4(3), jmp to tag
    ori   t1, t0,   0   # t1 = t0
    jalr  zero, ra, 0   # pc = ra
    
tag:
    addi  t0, t0, -1    # t0--

    addi  sp, sp, -4    # sp-=4        # push ra to stack
    sw    ra, (sp)      # mem[sp] = ra
    
    addi  sp, sp, -4    # sp-=4        # push t0 to stack
    sw    t0, (sp)      # mem[sp] = t0
    
    jal   ra, Fibonacci # 计算 Fib(n-1)
    
    lw    t0, (sp)      # t0=mem[sp]   # pop t0 from stack
    addi  t0, t0, -1    # t0--

    sw    t1, (sp)      # mem[sp] = t1
    jal   ra, Fibonacci # 计算 Fib(n-2)
    lw    t2, (sp)      # ra=mem[sp]   # pop t2 from stack
    addi  sp, sp,  4    # sp+=4
    add   t1, t1, t2    # t1+=t2
    
    lw    ra, (sp)      # ra=mem[sp]   # pop ra from stack
    addi  sp, sp,  4    # sp+=4
    
    jalr  zero, ra,0    # pc = ra

    