#include "uart.h"


/*********************************************************************
 * @fn      uart_send_date
 *
 * @brief   串口发送数据
 *
 * @param   uart_send - 需要发送的数据
 *
 * @return  返回0则发送成功
 */
uint32_t uart_send_date(uint8_t uart_send)
{
    SYS_RWMEM_B(UART_TX)=uart_send;
    return 0;
}

