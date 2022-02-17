-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_mux2t1_data_flow.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the mux2t1 data flow unit
--              
-- 01/22/2022 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_mux2t1_data_flow is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_mux2t1_data_flow;

architecture mixed of tb_mux2t1_data_flow is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component mux2t1_data_flow is

  port(iA     : in std_logic;
       iB     : in std_logic;
       iSel   : in std_logic;
       oX     : out std_logic);

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal A, B, S : std_logic := '0';
signal O : std_logic;

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: mux2t1_data_flow
  port map(
          iA     => A,
          iB     => B,
          iSel   => S,
          oX     => O);
  --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER*2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- Test case 1:
    A       <= '0'; 
    B       <= '0';
    S       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 1:
    A       <= '0'; 
    B       <= '1';
    S       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 1:
    A       <= '1'; 
    B       <= '0';
    S       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 1:
    A       <= '1'; 
    B       <= '1';
    S       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 1:
    A       <= '0'; 
    B       <= '0';
    S       <= '1';
    wait for gCLK_HPER*2;

    -- Test case 1:
    A       <= '0'; 
    B       <= '1';
    S       <= '1';
    wait for gCLK_HPER*2;

    -- Test case 1:
    A       <= '1'; 
    B       <= '0';
    S       <= '1';
    wait for gCLK_HPER*2;

    -- Test case 1:
    A       <= '1'; 
    B       <= '1';
    S       <= '1';
    wait for gCLK_HPER*2;

    
    
    end process;

end mixed;
