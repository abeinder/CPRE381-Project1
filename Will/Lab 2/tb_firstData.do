#########################################################################
## Will Galles
## Department of Electrical and Computer Engineering
## Iowa State University
#########################################################################
## tb_firstData.do
#########################################################################
## DESCRIPTION: This file contains a do file for the testbench for the 
##              n-bit register
##              
## 01/04/2020 by H3::Design created.
#########################################################################

vcom -2008 -work work *.vhd

vsim -voptargs=+acc tb_firstData



add wave -noupdate -label CLK /tb_firstData/s_CLK
add wave -noupdate -label reset /tb_firstData/s_RST

add wave -noupdate -divider {Inputs}
add wave -noupdate -label Write_Enable /tb_firstData/s_WE
add wave -noupdate -label AddSub /tb_firstData/s_nAddSub
add wave -noupdate -label Use_Imd /tb_firstData/s_ALUSrc

add wave -noupdate -divider {Registers}
add wave -noupdate -label Source /tb_firstData/s_RS
add wave -noupdate -label Target /tb_firstData/s_RT
add wave -noupdate -label Destination /tb_firstData/s_RD


add wave -noupdate -divider {Register File}

add wave -noupdate -label Register_File /tb_firstData/DUT/REGISTERFILE/s_Q


run 2300
