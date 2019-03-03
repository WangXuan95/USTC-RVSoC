.org 0x0
 	.global _start
_start:
    lui   a0, 0x00010
    auipc a1, 0x00010
    sw    a1, 0(a0)
    auipc a1, 0x20000
    sw    a1, 4(a0)
    auipc a1, 0x03000
    sw    a1, 8(a0)
    auipc a1, 0x00a00
    sw    a1, 12(a0)
here: jal   zero, here
