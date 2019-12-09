
## Clock signal

##RGB LEDs
#set_property -dict { PACKAGE_PIN F6    IOSTANDARD LVCMOS33 } [get_ports { LEDG[0] }]; #IO_L19N_T3_VREF_35 Sch=led0_g
#set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { LEDR[0] }]; #IO_L19P_T3_35 Sch=led0_r
#set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { LEDG[1] }]; #IO_L21P_T3_DQS_35 Sch=led1_g
#set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { LEDR[1] }]; #IO_L20N_T3_35 Sch=led1_r
#set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { LEDB[2] }]; #IO_L21N_T3_DQS_35 Sch=led2_b
#set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { LEDG[2] }]; #IO_L22N_T3_35 Sch=led2_g
#set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { LEDR[2] }]; #IO_L22P_T3_35 Sch=led2_r
#set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { LEDB[3] }]; #IO_L23P_T3_35 Sch=led3_b
#set_property -dict { PACKAGE_PIN H6    IOSTANDARD LVCMOS33 } [get_ports { LEDG[3] }]; #IO_L24P_T3_35 Sch=led3_g
#set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { LEDR[3] }]; #IO_L23N_T3_35 Sch=led3_r

##LEDs

##USB-UART Interface

##Quad SPI Flash
#set_property -dict { PACKAGE_PIN L13   IOSTANDARD LVCMOS33 } [get_ports { FLASH_CS }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_cs
#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { FLASH_DQ[0] }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_dq[0]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { FLASH_DQ[1] }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_dq[1]
#set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { FLASH_DQ[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_dq[2]
#set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { FLASH_DQ[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_dq[3]

set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports CLK_50]
set_property IOSTANDARD LVCMOS33 [get_ports UART_RXD]
set_property IOSTANDARD LVCMOS33 [get_ports UART_TXD]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_HS]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_VS]
set_property PACKAGE_PIN D8 [get_ports {VGA_G[3]}]
set_property PACKAGE_PIN A3 [get_ports {VGA_G[2]}]
set_property PACKAGE_PIN A4 [get_ports {VGA_G[1]}]
set_property PACKAGE_PIN B6 [get_ports {VGA_G[0]}]
set_property PACKAGE_PIN E7 [get_ports {VGA_B[3]}]
set_property PACKAGE_PIN A1 [get_ports {VGA_B[2]}]
set_property PACKAGE_PIN B1 [get_ports {VGA_B[1]}]
set_property PACKAGE_PIN C7 [get_ports {VGA_B[0]}]
set_property PACKAGE_PIN C5 [get_ports {VGA_R[2]}]
set_property PACKAGE_PIN C6 [get_ports {VGA_R[1]}]
set_property PACKAGE_PIN F5 [get_ports {VGA_R[0]}]
set_property PACKAGE_PIN P17 [get_ports CLK_50]
set_property PACKAGE_PIN B7 [get_ports {VGA_R[3]}]



set_property PACKAGE_PIN N5 [get_ports UART_RXD]
set_property PACKAGE_PIN T4 [get_ports UART_TXD]
set_property PACKAGE_PIN D7 [get_ports VGA_HS]
set_property PACKAGE_PIN D5 [get_ports VGA_VS]

set_property IOSTANDARD LVCMOS33 [get_ports {DIG[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DIG[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DIG[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DIG[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DIG[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DIG[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DIG[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DIG[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEL[0]}]
set_property PACKAGE_PIN D4 [get_ports {DIG[0]}]
set_property PACKAGE_PIN H2 [get_ports {DIG[7]}]
set_property PACKAGE_PIN D2 [get_ports {DIG[6]}]
set_property PACKAGE_PIN E2 [get_ports {DIG[5]}]
set_property PACKAGE_PIN F3 [get_ports {DIG[4]}]
set_property PACKAGE_PIN F4 [get_ports {DIG[3]}]
set_property PACKAGE_PIN D3 [get_ports {DIG[2]}]
set_property PACKAGE_PIN E3 [get_ports {DIG[1]}]
set_property PACKAGE_PIN J2 [get_ports {SEL[5]}]
set_property PACKAGE_PIN K2 [get_ports {SEL[4]}]
set_property PACKAGE_PIN F6 [get_ports {SEL[3]}]
set_property PACKAGE_PIN G4 [get_ports {SEL[2]}]



set_property PACKAGE_PIN G3 [get_ports {SEL[1]}]
set_property PACKAGE_PIN J4 [get_ports {SEL[0]}]
set_property PACKAGE_PIN J3 [get_ports {SEL[6]}]
set_property PACKAGE_PIN H4 [get_ports {SEL[7]}]
