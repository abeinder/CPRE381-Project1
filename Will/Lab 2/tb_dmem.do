#########################################################################
## Will Galles
## Department of Electrical and Computer Engineering
## Iowa State University
#########################################################################
## tb_dmem.do
#########################################################################
## DESCRIPTION: This file contains a do file for the testbench for the 
##              n-bit register
##              
## 01/04/2020 by H3::Design created.
#########################################################################

vcom -2008 -work work *.vhd



vsim -voptargs=+acc tb_dmem

mem load -infile dmem.hex -format hex /tb_dmem/dmem/ram 



add wave -noupdate -label CLK /tb_dmem/s_CLK
#add wave -noupdate -label reset /tb_dmem/s_RST

add wave -noupdate -divider {Inputs}
add wave -noupdate -label Write_Enable /tb_dmem/s_WE
add wave -noupdate -label Address /tb_dmem/s_Addr
add wave -noupdate -signed -label Data /tb_dmem/s_Data

add wave -noupdate -signed -label Out /tb_dmem/s_O

run 3000
