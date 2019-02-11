.org 0x0
 	.global _start
_start:
    addi  zero, zero, 0x123
    addi  zero, zero, 0x456
    
    lui   sp, 0x00010
    ori   sp, sp, 0x400 # stack pointer=0x400, stack size = 256 dwords
    
    xori  t0, zero, 7   # t0 = 7
    jal   ra, fibonacci_recursive   # fib(7) = 21 = 0x15
    
    jal   zero, print_result        # 跳到死循环打印程序，循环打印斐波那契计算结果，应该打印的是0x15

fibonacci_recursive:    # 递归计算斐波那契数列的第n项，
                        # n放在t0寄存器中
                        # 结果放在t1寄存器中
                        # 使用ra作为返回地址，并使用堆栈，堆栈指针为sp
    
    ori   a0, zero, 3   # a0 = 3
    bgeu  t0, a0, tag   # if t0>=a0(3), jmp to tag
    ori   t1, t0,   0   # t1 = t0
    jalr  zero, ra, 0   # pc = ra
    
tag:
    addi  sp, sp, -4    # sp-=4        # push ra to stack
    sw    ra, (sp)      # mem[sp] = ra
    
    addi  t0, t0, -1    # t0-=1
    addi  sp, sp, -4    # sp-=4        # push t0 to stack
    sw    t0, (sp)      # mem[sp] = t0
    
    jal   ra, fibonacci_recursive      # fibonacci_recursive n-1
    
    lw    t0, 0(sp)     # t0=mem[sp]   # pop t0 from stack
    addi  sp, sp,  4    # sp+=4
    addi  t0, t0, -1    # t0-=1
    
    addi  sp, sp, -4    # sp-=4        # push t1 to stack
    sw    t1, (sp)      # mem[sp] = t1
    jal   ra, fibonacci_recursive      # fibonacci_recursive n-2
    lw    t2, 0(sp)     # ra=mem[sp]   # pop t2 from stack
    addi  sp, sp,  4    # sp+=4
    add   t1, t1, t2    # t1+=t2
    
    lw    ra, 0(sp)     # ra=mem[sp]   # pop ra from stack
    addi  sp, sp,  4    # sp+=4
    
    jalr  zero, ra,0    # pc = ra
    
print_result:            # 延时循环打印斐波那契计算结果
    or    t0, zero,zero # t0 清零
    lui   t0, 0x00030   # t0 寄存器的高20bit=0x00020
    sb    t1, (t0)      # 计算完成，结果在t1中，用USER-UART打印出来
    lui   t2, 0x00c00          # t2 = 0x00800000
big_loop:
    addi  t2, t2, -1           # t2 = t2-1
    bne   t2, zero, big_loop   # if t2!=0, jmp to big_loop
    jal   zero, print_result   # 大循环结束，跳到print_result，重复打印
    