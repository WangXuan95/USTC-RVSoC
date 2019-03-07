

.org 0x0
    .global _start
_start:

main:

    lui    a0, 0x00010
    ori    t3, zero, 4
    sw     t3  , (a0)

    ori    t2, zero, 32
    sw     t2, 16(a0)
    ori    t2, zero, 16
    add    t3, a0, t2
    or     zero, zero, zero
    or     zero, zero, zero
    or     zero, zero, zero
    or     zero, zero, zero
    or     zero, zero, zero
    or     zero, zero, zero
    or     zero, zero, zero

    lw     t3, (t3)
    beq    a0, a0, PartationFirstEnd
    add    zero, t3, zero
    
    PartationFirstEnd:

    sw     t3  , (a0)


infinity_loop:
    jal   zero, infinity_loop
