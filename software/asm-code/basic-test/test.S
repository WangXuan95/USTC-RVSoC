
.org 0x0
    .global _start
_start:

    lui    a0, 0x00010
    addi   t2, zero, 0x04                 # t2 = 4
    sw     t2, 8(a0)                      # (0x00010008) = 4
    addi   t1, a0, 0x08                   # t1=0x00010008
    lw     t1, (t1)                       # t1 = 4
    blt    t1, t2, next                   # if t1<t2, branch to next step
    beq    t1, t2, next                   # if t1=t2, branch to next step
    addi   t2, t2, -4                     # t2-=4
    jal    zero, _start
next:
    add    t0  , a0, t1                   # t0=0x00010004
    sw     t2  , (t0)                     # (0x00010004) = 4
here:
    jal    zero, here
            