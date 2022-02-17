#########################################################################
## Austin Beinder
## Department of Electrical and Computer Engineering
## Iowa State University
#########################################################################
## tb_adder.do
#########################################################################
## DESCRIPTION: This file contains a do file for the testbench for ripple
##              carry adder.
##              
## 1/30/22 by Austin Beinder::Design created.
#########################################################################

# Setup the wave form with useful signals

# Add the standard, non-data clock and reset input signals.
# First, add a helpful header label.
add wave -noupdate -divider {Standard Inputs}
add wave -noupdate -radix unsigned /tb_adder/A
add wave -noupdate -radix unsigned /tb_adder/B
add wave -noupdate -label Control /tb_adder/Cin

# Add data outputs that are specific to this design. These are the ones that we'll check for correctness.
add wave -noupdate -divider {Data Outputs}
add wave -noupdate -radix unsigned /tb_adder/O
add wave -noupdate -radix unsigned /tb_adder/Cout


# The following command will add all of the signals within the DUT0 module's scope (but not internal
# signals to submodules).
add wave -noupdate -divider {Internal Signals}
add wave -noupdate /tb_adder/DUT0/*

# TODO: Add your own signals as needed!



# Run for 100 timesteps (default is 1ns per timestep, but this can be modified so be aware).
run 400 