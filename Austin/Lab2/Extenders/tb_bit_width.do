#########################################################################
## Austin Beinder
## Department of Electrical and Computer Engineering
## Iowa State University
#########################################################################
## tb_addsub.do
#########################################################################
## DESCRIPTION: This file contains a do file for the testbench for the 
##              addition and subtraction N bit calculator.
##              
## 1/30/22 by Austin Beinder::Design created.
#########################################################################

vcom -2008 -work work Lab2/*.vhd Lab2/Extenders/*.vhd

vsim work.tb_bit_width -voptargs=+acc

# Setup the wave form with useful signals

# Add the standard, non-data clock and reset input signals.
# First, add a helpful header label.
add wave -noupdate -divider {Standard Inputs}
add wave -noupdate -radix signed /tb_bit_width/A
add wave -noupdate -radix unsigned /tb_bit_width/En

# Add data outputs that are specific to this design. These are the ones that we'll check for correctness.
add wave -noupdate -divider {Data Outputs}
add wave -noupdate -radix signed /tb_bit_width/O


# The following command will add all of the signals within the DUT0 module's scope (but not internal
# signals to submodules).
add wave -noupdate -divider {Internal Signals}
add wave -noupdate /tb_bit_width/DUT0/*

# TODO: Add your own signals as needed!



# Run for 100 timesteps (default is 1ns per timestep, but this can be modified so be aware).
run 100 