#########################################################################
## Will Galles
## Department of Electrical and Computer Engineering
## Iowa State University
#########################################################################
## tb_reg_N.do
#########################################################################
## DESCRIPTION: This file contains a do file for the testbench for the 
##              n-bit register
##              
## 01/04/2020 by H3::Design created.
#########################################################################

vcom -2008 -work work *.vhd

vsim -voptargs=+acc tb_reg_N



add wave -noupdate -divider {Standard Inputs}
add wave -noupdate -label CLK /tb_reg_N/s_CLK
#add wave -noupdate -label reset /tb_reg_N/reset

add wave -noupdate -divider {Data Inputs}
add wave -noupdate /tb_reg_N/s_RST
add wave -noupdate /tb_reg_N/s_WE
add wave -noupdate /tb_reg_N/s_D


# Add data outputs that are specific to this design. These are the ones that we'll check for correctness.
add wave -noupdate -divider {Data Outputs}
add wave -noupdate /tb_reg_N/s_Q



run 700
