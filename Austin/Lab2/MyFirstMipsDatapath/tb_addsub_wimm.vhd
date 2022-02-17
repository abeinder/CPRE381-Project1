-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_addsub_wimm.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the addition and subtraction
--              N bit calculator with the option for imm
--              
-- 2/13/2022 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_addsub_wimm is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_addsub_wimm;

architecture mixed of tb_addsub_wimm is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;


component addsub_wimm is
    generic(N : integer := 32);
    port(i_A      : in std_logic_vector(N-1 downto 0);
         i_B      : in std_logic_vector(N-1 downto 0);
         i_imm      : in std_logic_vector(N-1 downto 0);
         nAdd_Sub : in std_logic;
         ALUsrc   : in std_logic;
         o_F      : out std_logic_vector(N-1 downto 0));

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal A, B : STD_LOGIC_VECTOR(4-1 downto 0) := "0000";
signal imm : STD_LOGIC_VECTOR(4-1 downto 0) := "0000";
signal add_sub_sig : std_logic := '0';
signal aluscr : std_logic := '0';
signal O : STD_LOGIC_VECTOR(4-1 downto 0);

begin

  DUT0: addsub_wimm
    generic map (N => 4)
    port map(
          i_A          => A,
          i_B          => B,
          i_imm        => imm,
          nAdd_Sub     => add_sub_sig,
          ALUsrc       => aluscr,
          o_F          => O);

  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER*2; -- for waveform clarity, I prefer not to change inputs on clk edges
    ----------------------------------------------
    -- Test case 1:
    A             <= 4x"9"; 
    B             <= 4x"5";
    imm           <= 4x"4";
    add_sub_sig   <= '0';
    aluscr        <= '0';
    wait for gCLK_HPER*2;

    -- Test case 1:
    A             <= 4x"9"; 
    B             <= 4x"5";
    imm           <= 4x"4";
    add_sub_sig   <= '1';
    aluscr        <= '0';
    wait for gCLK_HPER*2;

    -- Test case 1:
    A             <= 4x"9"; 
    B             <= 4x"5";
    imm           <= 4x"4";
    add_sub_sig   <= '0';
    aluscr        <= '1';
    wait for gCLK_HPER*2;

    -- Test case 1:
    A             <= 4x"9"; 
    B             <= 4x"5";
    imm           <= 4x"4";
    add_sub_sig   <= '1';
    aluscr        <= '1';
    wait for gCLK_HPER*2;

    
    end process;

end mixed;
