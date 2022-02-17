-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_addsub.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the addition and subtraction
--              N bit calculator
--              
-- 01/30/2022 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_add_sub is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_add_sub;

architecture mixed of tb_add_sub is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component add_sub is
    generic(N : integer := 32);
    port(i_A      : in std_logic_vector(N-1 downto 0);
         i_B      : in std_logic_vector(N-1 downto 0);
         nAdd_Sub : in std_logic;
         o_F      : out std_logic_vector(N-1 downto 0));

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal A, B : STD_LOGIC_VECTOR(4-1 downto 0) := "0000";
signal add_sub_sig : std_logic := '0';
signal O : STD_LOGIC_VECTOR(4-1 downto 0);

begin

  DUT0: add_sub
  
    generic map (N => 4)
    port map(
          i_A          => A,
          i_B          => B,
          nAdd_Sub     => add_sub_sig,
          o_F          => O);

  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER*2; -- for waveform clarity, I prefer not to change inputs on clk edges
    ----------------------------------------------
    -- Test case 1:
    -- 2 random 4 bit integers, S=0
    A             <= "0011"; 
    B             <= "1010";
    add_sub_sig       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 2:
    -- 2 random 4 bit integers, S=1
    A             <= "0011"; 
    B             <= "1010";
    add_sub_sig       <= '1';
    wait for gCLK_HPER*2;
    ----------------------------------------------
    -- Test case 3:
    -- 2 more random 4 bit integers, S=0
    A             <= "1111"; 
    B             <= "0010";
    add_sub_sig       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 4:
    -- 2 random 4 bit integers, S=1
    A             <= "1111"; 
    B             <= "0010";
    add_sub_sig       <= '1';
    wait for gCLK_HPER*2;
    ----------------------------------------------
    -- Test case 5:
    -- 2 more random 4 bit integers, S=0
    A             <= "1010"; 
    B             <= "0010";
    add_sub_sig       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 6:
    -- 2 random 4 bit integers, S=1
    A             <= "1010"; 
    B             <= "0010";
    add_sub_sig       <= '1';
    wait for gCLK_HPER*2;
    ----------------------------------------------
    -- Test case 7:
    -- 2 more random 4 bit integers, S=0
    A             <= "1000"; 
    B             <= "0110";
    add_sub_sig       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 8:
    -- 2 random 4 bit integers, S=1
    A             <= "1000"; 
    B             <= "0110";
    add_sub_sig       <= '1';
    wait for gCLK_HPER*2;
    ----------------------------------------------
    -- Test case 9:
    -- 2 more random 4 bit integers, S=0
    A             <= "1110"; 
    B             <= "1101";
    add_sub_sig       <= '0';
    wait for gCLK_HPER*2;
    
    -- Test case 10:
    -- 2 random 4 bit integers, S=1
    A             <= "1110"; 
    B             <= "1101";
    add_sub_sig       <= '1';
    wait for gCLK_HPER*2;
    ----------------------------------------------
    -- Test case 11:
    -- 2 more random 4 bit integers, S=0
    A             <= "1011"; 
    B             <= "1111";
    add_sub_sig       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 12:
    -- 2 random 4 bit integers, S=1
    A             <= "1011"; 
    B             <= "1111";
    add_sub_sig       <= '1';
    wait for gCLK_HPER*2;
    ----------------------------------------------
    -- Test case 13:
    -- 2 more random 4 bit integers, S=0
    A             <= "0110"; 
    B             <= "0110";
    add_sub_sig       <= '0';
    wait for gCLK_HPER*2;

    -- Test case 14:
    -- 2 random 4 bit integers, S=1
    A             <= "0110"; 
    B             <= "0110";
    add_sub_sig       <= '1';
    wait for gCLK_HPER*2;

    end process;

end mixed;
