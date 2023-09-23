#ifndef _UART_H_
#define _UART_H_
#include "system.h"

#define UART_BASE             (0x00030000)

#define UART_TX               (UART_BASE + (0x00))

uint32_t uart_send_date(uint8_t uart_send);//串口发送

#endif
