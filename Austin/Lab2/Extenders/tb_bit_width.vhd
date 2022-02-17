-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_reg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for an implementation of a register.
--              
-- 02/03/2022 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O
use IEEE.numeric_std.all;

entity tb_bit_width is
  generic(gCLK_HPER   : time := 10 ns); 
end tb_bit_width;

architecture mixed of tb_bit_width is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component bit_width_extender_16to32 is
  port(
       i_A              : in std_logic_vector(16-1 downto 0);
       iSel             : in std_logic; -- if 0, 0 extend, else sign extend
       oC               : out std_logic_vector(32-1 downto 0)
    );

end component;

signal A : STD_LOGIC_VECTOR(16-1 downto 0) := 16x"0000";
signal En : std_logic := '0';
signal O : STD_LOGIC_VECTOR(32-1 downto 0);

begin

  DUT0: bit_width_extender_16to32
    port map(
      i_A    => A,
      iSel   => En,
      oC     => O);

  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER*2;

    A <= 16x"0001"; --Input = 1
    En <= '0';      --Output =1
    wait for gCLK_HPER;
    A <= 16x"0001"; --Output =1
    En <= '1';
    wait for gCLK_HPER;

    A <= 16x"8001"; --Input = 32769
    En <= '0';      --Output =32769
    wait for gCLK_HPER;
    A <= 16x"8001"; --Output =-32767
    En <= '1';
    wait for gCLK_HPER;

    A <= 16x"F001"; --Input = 61441
    En <= '0';      --Output =61441
    wait for gCLK_HPER;
    A <= 16x"F001"; --Output =-4095
    En <= '1';
    wait for gCLK_HPER;

    A <= 16x"7FF1"; --Input = 32753
    En <= '0';      --Output =32753
    wait for gCLK_HPER;
    A <= 16x"7FF1"; --Output =32753
    En <= '1';
    wait for gCLK_HPER;


    end process;

end mixed;
