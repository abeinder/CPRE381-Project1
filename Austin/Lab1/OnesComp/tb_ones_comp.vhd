-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_ones_comp.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the ones complement 
--              structural description.
--              
-- 01/23/2022 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_ones_comp is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_ones_comp;

architecture mixed of tb_ones_comp is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component ones_comp_behav is
  generic (N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

component ones_comp_struct is
  generic (N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
      o_F          : out std_logic_vector(N-1 downto 0));
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal A : STD_LOGIC_VECTOR(4-1 downto 0) := "0000";
signal O1, O2 : STD_LOGIC_VECTOR(4-1 downto 0);

begin

  DUT0: ones_comp_behav
  generic map (N => 4)
  port map(
          i_A     => A,
          o_F     => O1);

  DUT1: ones_comp_struct
  generic map (N => 4)
  port map(
          i_A     => A,
          o_F     => O2);

  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER*2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- Test case 1:
    -- 2 random 4 bit integers, S=0
    A       <= "0011"; 
    wait for gCLK_HPER*2;

    -- Test case 2:
    -- 2 random 4 bit integers, S=1
    A       <= "0011"; 
    wait for gCLK_HPER*2;

    -- Test case 3:
    -- 2 more random 4 bit integers, S=0
    A       <= "1111"; 
    wait for gCLK_HPER*2;

    -- Test case 4:
    -- 2 random 4 bit integers, S=1
    A       <= "1111"; 
    wait for gCLK_HPER*2;

    end process;

end mixed;
