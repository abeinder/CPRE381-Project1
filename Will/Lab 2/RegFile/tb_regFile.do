#########################################################################
## Will Galles
## Department of Electrical and Computer Engineering
## Iowa State University
#########################################################################
## tb_regFile.do
#########################################################################
## DESCRIPTION: This file contains a do file for the testbench for the 
##              n-bit register
##              
## 01/04/2020 by H3::Design created.
#########################################################################

vcom -2008 -work work *.vhd

vsim -voptargs=+acc tb_regFile



add wave -noupdate -divider {Standard Inputs}
add wave -noupdate -label CLK /tb_regFile/s_CLK
add wave -noupdate -label reset /tb_regFile/s_RST

add wave -noupdate -divider {Write}
add wave -noupdate -label Write_Enable /tb_regFile/s_We
add wave -noupdate -label Reg_Write /tb_regFile/s_SW
add wave -noupdate -label Input /tb_regFile/s_I

add wave -noupdate -divider {Read}
add wave -noupdate -label Reg_Read1 /tb_regFile/s_SR1
add wave -noupdate -label Reg_Read2 /tb_regFile/s_SR2
add wave -noupdate -label Output1 /tb_regFile/s_O1
add wave -noupdate -label Output2 /tb_regFile/s_O2


add wave -noupdate -divider {Register File}


add wave -noupdate /tb_regFile/DUT/s_Q



# Add data outputs that are specific to this design. These are the ones that we'll check for correctness.
#add wave -noupdate -divider {Data Outputs}
#add wave -noupdate /tb_regFile/s_O



run 700
