#########################################################################
## Austin Beinder
## Department of Electrical and Computer Engineering
## Iowa State University
#########################################################################
## ones_comp_struct2.do
#########################################################################
## DESCRIPTION: This file contains a do file for the testbench for the 
##              behavioral description of the ones complement device.
##              
## 1/23/22 by Austin Beinder::Design created.
#########################################################################

# Setup the wave form with useful signals

# Add the standard, non-data clock and reset input signals.
# First, add a helpful header label.
add wave -noupdate -divider {Standard Inputs}
add wave -noupdate -label A /tb_ones_comp2/A

# Add data outputs that are specific to this design. These are the ones that we'll check for correctness.
add wave -noupdate -divider {Data Outputs}
add wave -noupdate -radix unsigned /tb_ones_comp2/O1
add wave -noupdate -radix unsigned /tb_ones_comp2/O2

# TODO: Add your own signals as needed!



# Run for 100 timesteps (default is 1ns per timestep, but this can be modified so be aware).
run 150 