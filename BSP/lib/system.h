#ifndef SYSTEM_H_
#define SYSTEM_H_

#include <stdint.h> //标准化变量位宽

#include "uart.h"

#define ENABLE 1
#define DISABLE 0



#define SYS_RWMEM_W(addr) (*((volatile uint32_t *)(addr)))   //字访存。必须4字节对齐访问(低2位为0)  SYS_RWMEM_W(0x008)
#define SYS_RWMEM_B(addr) (*((volatile uint8_t  *)(addr)))   //字节访存，允许访问4G地址空间任意字节 SYS_RWMEM_B(0x001)
/*
通过以下两种方式访存
aaa = SYS_RWMEM_W(0x008);//从0x008读一个字到aa
SYS_RWMEM_B(0x001) = bbb;//把bbb写入0x001
*/
#endif
