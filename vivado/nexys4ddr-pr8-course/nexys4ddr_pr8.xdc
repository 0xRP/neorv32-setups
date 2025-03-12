## This file is a general .xdc for the Nexys A7 and Nexys 4 DDR
## For default neorv32_test_setup.vhd top entity

## Clock signal
set_property -dict { PACKAGE_PIN E3   IOSTANDARD LVCMOS33 } [get_ports { clk_i }]; 	   #IO_L12P_T1_MRCC_35 	  Sch=gclk[100]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk_i }];

## LEDs
#
#set_property -dict { PACKAGE_PIN H17  IOSTANDARD LVCMOS33 } [get_ports { gpio_o_tri_o[0] }]; #IO_L18P_T2_A24_15 	  Sch=led[0]
#set_property -dict { PACKAGE_PIN K15  IOSTANDARD LVCMOS33 } [get_ports { gpio_o_tri_o[1] }]; #IO_L24P_T3_RS1_15 	  Sch=led[1]
#set_property -dict { PACKAGE_PIN J13  IOSTANDARD LVCMOS33 } [get_ports { gpio_o_tri_o[2] }]; #IO_L17N_T2_A25_15 	  Sch=led[2]
#set_property -dict { PACKAGE_PIN N14  IOSTANDARD LVCMOS33 } [get_ports { gpio_o_tri_o[3] }]; #IO_L8P_T1_D11_14  	  Sch=led[3]
#set_property -dict { PACKAGE_PIN R18  IOSTANDARD LVCMOS33 } [get_ports { gpio_o_tri_o[4] }]; #IO_L7P_T1_D09_14      Sch=led[4]
#set_property -dict { PACKAGE_PIN V17  IOSTANDARD LVCMOS33 } [get_ports { gpio_o_tri_o[5] }]; #IO_L18N_T2_A11_D27_14 Sch=led[5]
#set_property -dict { PACKAGE_PIN U17  IOSTANDARD LVCMOS33 } [get_ports { gpio_o_tri_o[6] }]; #IO_L17P_T2_A14_D30_14 Sch=led[6]
#set_property -dict { PACKAGE_PIN U16  IOSTANDARD LVCMOS33 } [get_ports { gpio_o_tri_o[7] }]; #IO_L18P_T2_A12_D28_14 Sch=led[7]

##Pmod Header JA

#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { JA[1] }]; #IO_L20N_T3_A19_15 Sch=ja[1]
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { JA[2] }]; #IO_L21N_T3_DQS_A18_15 Sch=ja[2]
set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { scl_io }]; #IO_L21P_T3_DQS_15 Sch=ja[3]
set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { sda_io }]; #IO_L18N_T2_A23_15 Sch=ja[4]
#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { JA[7] }]; #IO_L16N_T2_A27_15 Sch=ja[7]
#set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS33 } [get_ports { JA[8] }]; #IO_L16P_T2_A28_15 Sch=ja[8]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports { JA[9] }]; #IO_L22N_T3_A16_15 Sch=ja[9]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { JA[10] }]; #IO_L22P_T3_A17_15 Sch=ja[10]

## USB-UART Interface
set_property -dict { PACKAGE_PIN D4  IOSTANDARD LVCMOS33 } [get_ports { uart0_txd_o }]; #IO_L11N_T1_SRCC_35 Sch=uart_rxd_out
set_property -dict { PACKAGE_PIN C4  IOSTANDARD LVCMOS33 } [get_ports { uart0_rxd_i }]; #IO_L7P_T1_AD6P_35 	Sch=uart_txd_in

## Misc.
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports { rst_i }];     #IO_L3P_T0_DQS_AD1P_15 Sch=ck_rst
