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

entity tb_32_mux is
  generic(gCLK_HPER   : time := 10 ns); 
end tb_32_mux;

architecture mixed of tb_32_mux is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component mux_32_32to1 is
  port(
       i_00             : in std_logic_vector(32-1 downto 0);
       i_01             : in std_logic_vector(32-1 downto 0);
       i_02             : in std_logic_vector(32-1 downto 0);
       i_03             : in std_logic_vector(32-1 downto 0);
       i_04             : in std_logic_vector(32-1 downto 0);
       i_05             : in std_logic_vector(32-1 downto 0);
       i_06             : in std_logic_vector(32-1 downto 0);
       i_07             : in std_logic_vector(32-1 downto 0);
       i_08             : in std_logic_vector(32-1 downto 0);
       i_09             : in std_logic_vector(32-1 downto 0);
       i_0A             : in std_logic_vector(32-1 downto 0);
       i_0B             : in std_logic_vector(32-1 downto 0);
       i_0C             : in std_logic_vector(32-1 downto 0);
       i_0D             : in std_logic_vector(32-1 downto 0);
       i_0E             : in std_logic_vector(32-1 downto 0);
       i_0F             : in std_logic_vector(32-1 downto 0);

       i_10             : in std_logic_vector(32-1 downto 0);
       i_11             : in std_logic_vector(32-1 downto 0);
       i_12             : in std_logic_vector(32-1 downto 0);
       i_13             : in std_logic_vector(32-1 downto 0);
       i_14             : in std_logic_vector(32-1 downto 0);
       i_15             : in std_logic_vector(32-1 downto 0);
       i_16             : in std_logic_vector(32-1 downto 0);
       i_17             : in std_logic_vector(32-1 downto 0);
       i_18             : in std_logic_vector(32-1 downto 0);
       i_19             : in std_logic_vector(32-1 downto 0);
       i_1A             : in std_logic_vector(32-1 downto 0);
       i_1B             : in std_logic_vector(32-1 downto 0);
       i_1C             : in std_logic_vector(32-1 downto 0);
       i_1D             : in std_logic_vector(32-1 downto 0);
       i_1E             : in std_logic_vector(32-1 downto 0);
       i_1F             : in std_logic_vector(32-1 downto 0);

       iSel             : in std_logic_vector(5-1 downto 0);
       oC               : out std_logic_vector(32-1 downto 0));
  end component;

signal S00, S01, S02, S03, S04, S05, S06, S07, S08, S09, S0A, S0B, S0C, S0D, S0E, S0F : STD_LOGIC_VECTOR(32-1 downto 0) := 32x"AAAAAAAA";
signal S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S1A, S1B, S1C, S1D, S1E, S1F : STD_LOGIC_VECTOR(32-1 downto 0) := 32x"0000BBBB";
signal SEL : STD_LOGIC_VECTOR(5-1 downto 0) := "00000";
signal O : STD_LOGIC_VECTOR(32-1 downto 0);

begin

  DUT0: mux_32_32to1
  port map (
    i_00             => S00,
    i_01             => S01,
    i_02             => S02,
    i_03             => S03,
    i_04             => S04,
    i_05             => S05,
    i_06             => S06,
    i_07             => S07,
    i_08             => S08,
    i_09             => S09,
    i_0A             => S0A,
    i_0B             => S0B,
    i_0C             => S0C,
    i_0D             => S0D,
    i_0E             => S0E,
    i_0F             => S0F,

    i_10             => S10,
    i_11             => S11,
    i_12             => S12,
    i_13             => S13,
    i_14             => S14,
    i_15             => S15,
    i_16             => S16,
    i_17             => S17,
    i_18             => S18,
    i_19             => S19,
    i_1A             => S1A,
    i_1B             => S1B,
    i_1C             => S1C,
    i_1D             => S1D,
    i_1E             => S1E,
    i_1F             => S1F,

    iSel             => SEL,
    oC               => O);

  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    S00 <= 32x"11111111";
    S04 <= 32x"11111111";
    S13 <= 32x"11111111";
    wait for gCLK_HPER*2;

    ----------------------------------------------
    -- Test case 1:
    for ii in 0 to 31 loop
      wait for gCLK_HPER;
      SEL             <= STD_LOGIC_VECTOR(to_unsigned(ii, 5));
      wait for gCLK_HPER*2;

    end loop;
    
    ----------------------------------------------
    -- Test case 2:
    S00 <= 32x"FAFA8888";
    S04 <= 32x"FAFA8888";
    S13 <= 32x"FAFA8888";

    for ii in 0 to 31 loop
      wait for gCLK_HPER;
      SEL             <= STD_LOGIC_VECTOR(to_unsigned(ii, 5));
      wait for gCLK_HPER*2;


    end loop;
    end process;

end mixed;
