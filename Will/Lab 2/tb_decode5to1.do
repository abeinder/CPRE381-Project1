#########################################################################
## Will Galles
## Department of Electrical and Computer Engineering
## Iowa State University
#########################################################################
## tb_decode5to1.do
#########################################################################
## DESCRIPTION: This file contains a do file for the testbench for the 
##              n-bit register
##              
## 01/04/2020 by H3::Design created.
#########################################################################

vcom -2008 -work work *.vhd

vsim -voptargs=+acc tb_decode5to1



add wave -noupdate -divider {Standard Inputs}
add wave -noupdate -label CLK /tb_decode5to1/s_CLK
#add wave -noupdate -label reset /tb_decode5to1/reset

add wave -noupdate -divider {Data Inputs}
add wave -noupdate /tb_decode5to1/s_S
add wave -noupdate /tb_decode5to1/s_E



# Add data outputs that are specific to this design. These are the ones that we'll check for correctness.
add wave -noupdate -divider {Data Outputs}
add wave -noupdate /tb_decode5to1/s_O



run 700
