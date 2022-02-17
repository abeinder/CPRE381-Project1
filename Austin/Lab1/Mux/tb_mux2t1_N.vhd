-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_TPU_MV_Element.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the TPU MAC unit.
--              
-- 01/03/2020 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_mux2t1_N is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_mux2t1_N;

architecture mixed of tb_mux2t1_N is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component mux2t1_N is
  generic (N : integer := 16);
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(4-1 downto 0);
       i_D1         : in std_logic_vector(4-1 downto 0);
       o_O          : out std_logic_vector(4-1 downto 0));

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal A, B : STD_LOGIC_VECTOR(4-1 downto 0) := "0000";
signal S : std_logic := '0';
signal O : STD_LOGIC_VECTOR(4-1 downto 0);

begin

  DUT0: mux2t1_N
  generic map (N => 4)
  port map(
          i_D0     => A,
          i_D1     => B,
          i_S     => S,
          o_O     => O);

  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER*2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- Test case 1:
    -- 2 random 4 bit integers, S=0
    A       <= "0011"; 
    B       <= "1010";
    S       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 2:
    -- 2 random 4 bit integers, S=1
    A       <= "0011"; 
    B       <= "1010";
    S       <= '1';
    wait for gCLK_HPER*2;

    -- Test case 3:
    -- 2 more random 4 bit integers, S=0
    A       <= "1111"; 
    B       <= "0010";
    S       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 4:
    -- 2 random 4 bit integers, S=1
    A       <= "1111"; 
    B       <= "0010";
    S       <= '1';
    wait for gCLK_HPER*2;

    end process;

end mixed;
