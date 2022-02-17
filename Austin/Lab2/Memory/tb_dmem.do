#########################################################################
## Austin Beinder
## Department of Electrical and Computer Engineering
## Iowa State University
#########################################################################
## tb_processor_datapath1.do
#########################################################################
## DESCRIPTION: This file contains a do file for the testbench for the 
##              first datapath
##              
## 2/13/22 by Austin Beinder::Design created.
#########################################################################

vcom -2008 -work work Lab1/AddSub/*.vhd Lab1/Mux/*.vhd Lab2/*.vhd Lab2/RegFile/*.vhd Lab2/MyFirstMipsDatapath/*.vhd Lab2/Memory/*.vhd

vsim work.tb_dmem -voptargs=+acc
mem load -infile Lab2/dmem.hex -format hex /tb_dmem/dmem/ram 

# Setup the wave form with useful signals

# Add the standard, non-data clock and reset input signals.
# First, add a helpful header label.
add wave -noupdate -divider {Signals}
add wave -noupdate -radix decimal /tb_dmem/*

# The following command will add all of the signals within the DUT0 module's scope (but not internal
# signals to submodules).
add wave -noupdate -divider {Internal Signals}
add wave -noupdate /tb_dmem/dmem/*
# add wave -noupdate /tb_dmem/dmem/ram/*

# TODO: Add your own signals as needed!



# Run for 100 timesteps (default is 1ns per timestep, but this can be modified so be aware).
run 1600