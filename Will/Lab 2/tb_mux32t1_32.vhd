-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_mux32t1_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- edge-triggered flip-flop with parallel access and reset.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 11/25/19 by H3:Changed name to avoid name conflict with Quartus
--          primitives.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.my_array.all;


entity tb_mux32t1_32 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_mux32t1_32;

architecture behavior of tb_mux32t1_32 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  --constant n : integer :=16;

  component mux32t1_32 is
    port(i_S          : in std_logic_vector(4 downto 0);
         i_D          : in inputArray;
         o_Q          : out std_logic_vector(31 downto 0));
  end component;
  

  -- Temporary signals to connect to the dff component.
  signal s_CLK : std_logic;
  signal s_I : inputArray;
  signal s_O : std_logic_vector(31 downto 0);
  signal s_S : std_logic_vector(4 downto 0) := b"00000";

begin

  DUT: mux32t1_32 
  port map(i_S => s_S,
           i_D => s_I,
           o_Q => s_O);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin

    -- Set to 0
    s_I(0) <= 32x"0";
    s_I(1) <= 32x"1";
    s_I(2) <= 32x"2";
    s_I(3) <= 32x"3";
    s_I(4) <= 32x"4";
    s_I(5) <= 32x"5";
    s_I(6) <= 32x"6";
    s_I(7) <= 32x"7";
    s_I(8) <= 32x"8";
    s_I(9) <= 32x"9";
    s_I(10) <= 32x"a";
    s_I(11) <= 32x"b";
    s_I(12) <= 32x"c";
    s_I(13) <= 32x"d";
    s_I(14) <= 32x"e";
    s_I(15) <= 32x"f";
    s_I(16) <= 32x"10";
    s_I(17) <= 32x"11";
    s_I(18) <= 32x"12";
    s_I(19) <= 32x"13";
    s_I(20) <= 32x"14";
    s_I(21) <= 32x"15";
    s_I(22) <= 32x"16";
    s_I(23) <= 32x"17";
    s_I(24) <= 32x"18";
    s_I(25) <= 32x"19";
    s_I(26) <= 32x"1a";
    s_I(27) <= 32x"1b";
    s_I(28) <= 32x"1c";
    s_I(29) <= 32x"1d";
    s_I(30) <= 32x"1e";
    s_I(31) <= 32x"1f";

    wait for cCLK_PER;

    -- Set to 0
    s_S <= 5x"1";
    wait for cCLK_PER;

    -- Set to 0
    s_S <= 5x"1F";
    wait for cCLK_PER;

    -- Set to 0
    s_S <= 5x"11";
    wait for cCLK_PER;

    -- Set to 0
    s_S <= 5x"9";
    wait for cCLK_PER;

    -- Set to 0
    s_S <= 5x"17";
    wait for cCLK_PER;

    -- Set to 0
    s_S <= 5x"c";
    wait for cCLK_PER;
  

     

    wait;
  end process;
  
end behavior;
