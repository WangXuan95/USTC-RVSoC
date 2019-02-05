.org 0x0
 	.global _start
_start:
    ori   a0, zero, 0x200
    addi  a1, zero,  0xc8
    addi  a2, zero,  0x56
    addi  a3, zero,  0xa4
    addi  a4, zero,  0x12
    sb    a1, 0(a0)
    sb    a2, 1(a0)
    sb    a3, 2(a0)
    sb    a4, 3(a0)
    lw    t0, 0(a0)
    lb    t0, 0(a0)
    lb    t0, 1(a0)
    lb    t0, 2(a0)
    lb    t0, 3(a0)
    lbu   t0, 0(a0)
    lbu   t0, 1(a0)
    lbu   t0, 2(a0)
    lbu   t0, 3(a0)
    lh    t0, 0(a0)
    lh    t0, 2(a0)
    lhu   t0, 0(a0)
    lhu   t0, 2(a0)
    lui   a5, 0x12345
    addi  a5, a5, 0x678
    sh    a5, 16(a0)
    addi  t0, zero, 16
    srli  a6, a5, 16
    srl   a7, a5, t0
    sh    a7, 18(a0)
here: jal zero,here
