#########################################################################
## Will Galles
## Department of Electrical and Computer Engineering
## Iowa State University
#########################################################################
## tb_Bit16_32.do
#########################################################################
## DESCRIPTION: This file contains a do file for the testbench for the 
##              n-bit register
##              
## 01/04/2020 by H3::Design created.
#########################################################################

vcom -2008 -work work *.vhd



vsim -voptargs=+acc tb_Bit16_32

#mem load -infile dmem.hex -format hex /tb_Bit16_32/dmem/ram 



add wave -noupdate -label CLK /tb_Bit16_32/s_CLK
#add wave -noupdate -label reset /tb_Bit16_32/s_RST

add wave -noupdate -divider {Inputs}
add wave -noupdate -label Input /tb_Bit16_32/s_A
add wave -noupdate -label Signed /tb_Bit16_32/s_S

add wave -noupdate -divider {Outputs}
add wave -noupdate  -label Output /tb_Bit16_32/s_O

run 700
