#########################################################################
## Will Galles
## Department of Electrical and Computer Engineering
## Iowa State University
#########################################################################
## tb_secondData.do
#########################################################################
## DESCRIPTION: This file contains a do file for the testbench for the 
##              n-bit register
##              
## 01/04/2020 by H3::Design created.
#########################################################################

vcom -2008 -work work *.vhd

vsim -voptargs=+acc tb_secondData

mem load -infile dmem.hex -format hex /tb_secondData/DUT/dmem/ram 

add wave -noupdate -label CLK /tb_secondData/s_CLK
add wave -noupdate -label reset /tb_secondData/s_RST

add wave -noupdate -divider {Inputs}
add wave -noupdate -label Write_Enable_Register /tb_secondData/s_WE_R
add wave -noupdate -label Write_Enable_Memory /tb_secondData/s_WE_M
add wave -noupdate -label AddSub /tb_secondData/s_nAddSub
add wave -noupdate -label Use_Imd /tb_secondData/s_ALUSrc
add wave -noupdate -label ALU_Or_MEM /tb_secondData/s_ALU_MEM

add wave -noupdate -divider {Registers}
add wave -noupdate -label Immediate /tb_secondData/s_I
add wave -noupdate -label Source /tb_secondData/s_RS
add wave -noupdate -label Target /tb_secondData/s_RT
add wave -noupdate -label Destination /tb_secondData/s_RD


add wave -noupdate -divider {Register File}

add wave -noupdate -label Register_File /tb_secondData/DUT/REGISTERFILE/s_Q

#add wave -noupdate -label Address_Line /tb_secondData/DUT/s_A
#add wave -noupdate -label Return /tb_secondData/DUT/s_Q
#add wave -noupdate -label Data_In /tb_secondData/DUT/s_O2


run 2500
