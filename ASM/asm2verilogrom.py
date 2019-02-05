#coding: utf-8
#!/usr/bin/env python


# 作用：汇编.S文件并将指令流转换为verilog rom文件
# 命令示例：python asm2verilogrom.py uart_print.S uart_print.sv
# 请使用python2

import os
import sys
import binascii


verilog_head = '''// asm file name: %s
module instr_rom(
    input  logic clk, rst_n,
    naive_bus.slave  bus
);
    localparam  INSTR_CNT = 30'd%d;
    
    wire [0:INSTR_CNT-1] [31:0] instr_rom_cell = {
'''

verilog_tail = '''    };
    
    logic [29:0] cell_rd_addr;
    
    assign bus.rd_gnt = bus.rd_req;
    assign bus.wr_gnt = bus.wr_req;
    assign cell_rd_addr = bus.rd_addr[31:2];
    
    always @ (posedge clk or negedge rst_n)
        if(~rst_n)
            bus.rd_data <= 0;
        else begin
            if(bus.rd_req)
                bus.rd_data <= (cell_rd_addr>=INSTR_CNT) ? 0 : instr_rom_cell[cell_rd_addr];
            else
                bus.rd_data <= 0;
        end

endmodule
'''

RISCV_TOOLCHAIN_PATH = '.\\riscv32-gnu-toolchain-windows\\'

if len(sys.argv) != 3:
    print("  正确的命令格式：python asm2verilogrom.py aaa.S aaa.sv");
    print("  将aaa.S汇编后的指令流以verilog ROM的方式输出到aaa.sv中");
    print("  请确保使用python2");
    sys.exit()
    
INPUT  = sys.argv[1]
OUTPUT = sys.argv[2]

res = os.system( '%sriscv32-elf-as %s            -o compile_tmp.o   -march=rv32i' % (RISCV_TOOLCHAIN_PATH, INPUT) )
if res != 0:
    print('\n    Assembling Error!')
    sys.exit()
os.system( '%sriscv32-elf-ld compile_tmp.o -o compile_tmp.om'               % (RISCV_TOOLCHAIN_PATH       ) )
os.system( 'del compile_tmp.o'   )
os.system( '%sriscv32-elf-objcopy -O binary compile_tmp.om compile_tmp.bin' % (RISCV_TOOLCHAIN_PATH,      ) )
os.system( 'del compile_tmp.om'  )
s = binascii.b2a_hex( open('compile_tmp.bin', 'rb').read() )
os.system( 'del compile_tmp.bin' )

def byte_wise_reverse(b):
    return b[6:8] + b[4:6] + b[2:4] + b[0:2]

with open(OUTPUT, 'w') as f:
    f.write(verilog_head % (INPUT, len(s)//8))
    for i in range(0, len(s), 8):
        instr_addr = '0x%08x' % (i//2,)
        if i+8<len(s):
            f.write('        32\'h'+byte_wise_reverse(s[i:i+8])+',    //'+instr_addr+'\n')
        else:
            f.write('        32\'h'+byte_wise_reverse(s[i:i+8])+'     //'+instr_addr+'\n')
    f.write(verilog_tail)
    