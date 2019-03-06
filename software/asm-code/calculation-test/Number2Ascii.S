# 概述：数字转十进制ASCII码
# Author: WangXuan
# 
# 系统要求：1、具有一个数据RAM 
#           2、测试该代码时，不需要初始化DataRam，只需要将指令流烧入InstrRam。
#           3、请根据实际情况将a0设置为你的DataRam的地址，例如我的SoC 显存起始地址为0x00020000，则我将计算结果写入了0x00020000，在VGA上会显示转化之后的ASCII字符
#


.org 0x0
 	.global _start
_start:

    ori   a0, zero, 1395            # a0 = 1395
    add   a0, a0  , a0              # a0 = 2790
    add   a0, a0  , a0              # a0 = 5580
    jal   ra, Number2DecimalAscii   # 调用函数Number2DecimalAscii计算 a0 的十进制ASCII，结果应该是 0x30383535，存在 a0 里
    lui   t0, 0x00020               # t0 = 0x00020000
    sw    a0, 4(t0)                 # a0写入(t0)  （计算结果写入显存RAM）
infinity_loop:
    jal   zero, infinity_loop       # 死循环


Number2DecimalAscii:    
    # 函数:Number2DecimalAscii：计算a0里低13位二进制数对应的十进制的ASCII码，存放在a0里
    # 例:  a0=0x12345678，其低13位为0x1678，即5752
    #      则调用该函数后 a0=0x32353735，因为0x32, 0x35, 0x37, 0x35分别为2 5 7 5 的ASCII码
    # 之所以使用低13位，因为13位二进制数取值范围位0~8191，不会超过4位十进制数
    # 改变数据RAM： 无
    # 改变的寄存器：a0, t0, t1, t2
    # 调用方法：使用 jal ra, Number2DecimalAscii 指令调用，因为返回时需要用到 ra 寄存器作为返回地址
        lui   t0, 0x01fff              # t0  = 0x01fff000
        srl   t0, t0  , 12             # t0  = 0x00001fff
        and   t0, a0  , t0             # t0  = t0 & a0
        lui   a0, 0x30303              # a0  = 0x30303000
        ori   a0, a0  , 0x030          # a0  = 0x30303030

        ori   t1, zero, 1000           # t1  = 1000
    thousand:
        bltu  t0, t1  , thousand_next  # if t0<1000 jump to thousand_next
        addi  t0, t0  , -1000          # t0 -= 1000
        addi  a0, a0  , 0x1            # a0 += 0x00000001
        jal   zero, thousand           # jump to thousand
    thousand_next:
        
        ori   t1, zero, 100            # t1  = 100
    hundred:
        bltu  t0, t1  , hundred_next   # if t0<100  jump to hundred_next
        addi  t0, t0  , -100           # t0 -= 100
        addi  a0, a0  , 0x100          # a0 += 0x00000100
        jal   zero, hundred
    hundred_next:

        lui   t2, 0x00010              # t2  = 0x00010000
        ori   t1, zero, 10             # t1  = 10
    ten:
        bltu  t0, t1  , ten_next       # if t0<10   jump to ten_next
        addi  t0, t0  , -10            # t0 -= 10
        add   a0, a0  , t2             # a0 += 0x00010000
        jal   zero, ten
    ten_next:
        
        lui   t2, 0x01000              # t2  = 0x01000000
        ori   t1, zero, 1              # t1  = 1
    one:
        bltu  t0, t1  , one_next       # if t0<1    jump to one_next
        addi  t0, t0  , -1             # t0 -= 1
        add   a0, a0  , t2             # a0 += 0x01000000
        jal   zero, one
    one_next:
        jalr  zero, ra, 0
