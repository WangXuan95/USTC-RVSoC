#GCC路径
RISCV_PATH := ../RISC-V_Embedded_GCC
RISCV_GCC     := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-gcc)
RISCV_AS      := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-as)
RISCV_GXX     := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-g++)
RISCV_OBJDUMP := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-objdump)
RISCV_GDB     := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-gdb)
RISCV_AR      := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-ar)
RISCV_OBJCOPY := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-objcopy)
RISCV_READELF := $(abspath $(RISCV_PATH)/bin/riscv-none-embed-readelf)
TARGET = obj
.PHONY: all
all: $(TARGET)

#汇编文件路径
ASM_SRCS += ../lib/start.S #启动文件

#C文件路径
C_SRCS += ${wildcard ./*.c} 
C_SRCS += ${wildcard ../lib/*.c}
C_SRCS += ${wildcard ../lib/src/*.c}

#链接脚本路径
LINKER_SCRIPT := ../link.lds

#头文件路径
INCLUDES += -I./
INCLUDES += -I../lib
INCLUDES += -I../lib/include

LDFLAGS += -T $(LINKER_SCRIPT) -nostartfiles -Wl,--gc-sections -Wl,--check-sections

ASM_OBJS := $(ASM_SRCS:.S=.o)
C_OBJS := $(C_SRCS:.c=.o)

LINK_OBJS += $(ASM_OBJS) $(C_OBJS)
LINK_DEPS += $(LINKER_SCRIPT)

CLEAN_OBJS += $(TARGET) $(LINK_OBJS) $(TARGET).dump $(TARGET).bin

CFLAGS += -march=rv32i #支持的指令集
CFLAGS += -mabi=ilp32 #支持的ABI
CFLAGS += -mcmodel=medlow -ffunction-sections -fdata-sections -fno-builtin-printf -fno-builtin-malloc
CFLAGS += -O1 #优化等级

$(TARGET): $(LINK_OBJS) $(LINK_DEPS) Makefile
	$(RISCV_GCC) $(CFLAGS) $(INCLUDES) $(LINK_OBJS) -o $@ $(LDFLAGS)
	$(RISCV_OBJCOPY) -O binary $@ $@.bin
	$(RISCV_OBJDUMP) --disassemble-all $@ > $@.dump

$(ASM_OBJS): %.o: %.S
	$(RISCV_GCC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

$(C_OBJS): %.o: %.c
	$(RISCV_GCC) $(CFLAGS) $(INCLUDES) -c -o $@ $<

.PHONY: b2t
b2t:
	python ../bin2txt.py

.PHONY: clean
clean:
	rm -f $(CLEAN_OBJS) inst.txt
