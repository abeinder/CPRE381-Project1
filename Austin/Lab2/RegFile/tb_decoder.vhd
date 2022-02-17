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

entity tb_decoder is
  generic(gCLK_HPER   : time := 10 ns); 
end tb_decoder;

architecture mixed of tb_decoder is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component decoder_5to32 is
  port(
       iA               : in std_logic_vector(5-1 downto 0);
       iEn              : in std_logic;
       oC               : out std_logic_vector(32-1 downto 0));

end component;

signal A : STD_LOGIC_VECTOR(5-1 downto 0) := "00000";
signal En : std_logic := '1';
signal O : STD_LOGIC_VECTOR(32-1 downto 0);
signal CLK : std_logic := '0';

begin

  DUT0: decoder_5to32
    port map(
      iA               => A,
      iEn               => En,
      oC               => O);

  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER*2;

    ----------------------------------------------
    -- Test case 1:
    -- 2 random 4 bit integers, S=0
    for ii in 0 to 15 loop
      CLK           <= '1';
      wait for gCLK_HPER;
      A             <= STD_LOGIC_VECTOR(to_unsigned(ii, 5));
      wait for gCLK_HPER*2;

      CLK           <= '0';
      wait for gCLK_HPER*2;

    end loop;

    -- Test case 2:
    -- 2 random 4 bit integers, S=0
    En <= '0';
    for ii in 0 to 15 loop
      CLK           <= '1';
      wait for gCLK_HPER;
      A             <= STD_LOGIC_VECTOR(to_unsigned(ii, 5));
      wait for gCLK_HPER*2;

      CLK           <= '0';
      wait for gCLK_HPER*2;

    end loop;

    end process;

end mixed;
