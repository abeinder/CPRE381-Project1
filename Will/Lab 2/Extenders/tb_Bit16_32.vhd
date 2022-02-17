-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_Bit16_32.vhd
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


entity tb_Bit16_32 is
  generic(gCLK_HPER   : time := 50 ns);
end tb_Bit16_32;

architecture behavior of tb_Bit16_32 is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  --constant n : integer :=16;

  component Bit16_32 is
    port( i_A          : in std_logic_vector(15 downto 0);
          i_S          : in std_logic;
          o_O          : out  std_logic_vector(31 downto 0));
  
  end component;

  signal s_CLK : std_logic;
  signal s_A : std_logic_vector((15) downto 0) := 16x"0";
  signal s_S : std_logic := '0';
  signal s_O: std_logic_vector((31) downto 0);



begin

  BIT: Bit16_32 
  port map(i_A => s_A,
           i_S => s_S,
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

    s_S <= '1';
    s_A <= 16x"1000";

    wait for cCLK_PER;

    s_S <= '0';
    s_A <= 16x"1000";

    wait for cCLK_PER;

    s_S <= '0';
    s_A <= 16x"FFFF";

    wait for cCLK_PER;

    s_S <= '1';
    s_A <= 16x"FFFF";

    wait for cCLK_PER;

    s_S <= '0';
    s_A <= 16x"8080";

    wait for cCLK_PER;

    s_S <= '1';
    s_A <= 16x"8080";

    wait for cCLK_PER;

    s_S <= '0';
    s_A <= 16x"0808";

    wait for cCLK_PER;

    s_S <= '1';
    s_A <= 16x"0808";

    wait for cCLK_PER;
     

    wait;
  end process;
  
end behavior;
