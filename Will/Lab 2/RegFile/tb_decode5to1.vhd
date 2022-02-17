-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_decode5to1.vhd
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

entity tb_decode5to1 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_decode5to1;

architecture behavior of tb_decode5to1 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  --constant n : integer :=16;

  component decode5to1 is
    port(
        i_S    : in std_logic_vector(4 downto 0);
        i_E    : in std_logic;
        o_O     : out std_logic_vector(31 downto 0));
    end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK : std_logic;
  signal s_E : std_logic := '1';
  signal s_O : std_logic_vector(31 downto 0);
  signal s_S : std_logic_vector(4 downto 0) := b"00000";

begin

  DUT: decode5to1 
  port map(i_S => s_S,
           i_E => s_E,
           o_O => s_O);

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
    s_S <= b"00000";
    wait for cCLK_PER;

    -- Set to 0
    s_S <= b"00001";
    wait for cCLK_PER;

    -- Set to 0
    s_S <= b"00010";
    wait for cCLK_PER;

    -- Set to 0
    s_S <= b"00011";
    wait for cCLK_PER;

    -- Set to 0
    s_S <= b"11111";
    wait for cCLK_PER;

    -- Set to 0
    s_S <= b"10000";
    wait for cCLK_PER;

    -- Set to 0
    s_E <= '0';
    wait for cCLK_PER;

     

     

    wait;
  end process;
  
end behavior;
