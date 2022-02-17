-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_dmem.vhd
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


entity tb_dmem is
  generic(gCLK_HPER   : time := 50 ns);
end tb_dmem;

architecture behavior of tb_dmem is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  --constant n : integer :=16;

  component mem is

	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);

	port 
	(
		clk		: in std_logic;
		addr	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

end component;

  signal s_CLK : std_logic;
  signal s_Addr : std_logic_vector((9) downto 0) := 10x"0";
  signal s_WE : std_logic := '0';
  signal s_O: std_logic_vector((31) downto 0);
  signal s_Data : std_logic_vector((31) downto 0) := 32x"0";


begin

  dmem: mem 
  port map(clk => s_CLK,
           addr => s_Addr,
           data => s_Data,
           we => s_WE,
           q => s_O);

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

    s_Addr <= 10x"0";

    wait for cCLK_PER;

    s_Addr <= 10x"1";

    wait for cCLK_PER;

    s_Addr <= 10x"2";

    wait for cCLK_PER;

    s_Addr <= 10x"3";

    wait for cCLK_PER;

    s_Addr <= 10x"4";

    wait for cCLK_PER;

    s_Addr <= 10x"5";

    wait for cCLK_PER;

    s_Addr <= 10x"6";

    wait for cCLK_PER;

    s_Addr <= 10x"7";

    wait for cCLK_PER;

    s_Addr <= 10x"8";

    wait for cCLK_PER;

    s_Addr <= 10x"9";

    wait for cCLK_PER;

    s_WE <= '1';

    s_Addr <= 10x"100";
    s_Data <= 32x"FFFFFFFF";

    wait for cCLK_PER;

    s_Addr <= 10x"101";
    s_Data <= 32x"FFFFFFFE";

    wait for cCLK_PER;

    s_Addr <= 10x"102";
    s_Data <= 32x"FFFFFFFD";

    wait for cCLK_PER;

    s_Addr <= 10x"103";
    s_Data <= 32x"FFFFFFFC";

    wait for cCLK_PER;

    s_Addr <= 10x"104";
    s_Data <= 32x"FFFFFFFB";

    wait for cCLK_PER;

    s_Addr <= 10x"105";
    s_Data <= 32x"FFFFFFFA";

    wait for cCLK_PER;

    s_Addr <= 10x"106";
    s_Data <= 32x"FFFFFFF9";

    wait for cCLK_PER;

    s_Addr <= 10x"107";
    s_Data <= 32x"FFFFFFF8";

    wait for cCLK_PER;

    s_Addr <= 10x"108";
    s_Data <= 32x"FFFFFFF7";

    wait for cCLK_PER;

    s_Addr <= 10x"109";
    s_Data <= 32x"FFFFFFF6";

    wait for cCLK_PER;

    s_WE <= '0';

    s_Addr <= 10x"100";

    wait for cCLK_PER;

    s_Addr <= 10x"101";

    wait for cCLK_PER;

    s_Addr <= 10x"102";

    wait for cCLK_PER;

    s_Addr <= 10x"103";

    wait for cCLK_PER;

    s_Addr <= 10x"104";

    wait for cCLK_PER;

    s_Addr <= 10x"105";

    wait for cCLK_PER;

    s_Addr <= 10x"106";

    wait for cCLK_PER;

    s_Addr <= 10x"107";

    wait for cCLK_PER;

    s_Addr <= 10x"108";

    wait for cCLK_PER;

    s_Addr <= 10x"109";

    wait for cCLK_PER;
    
    

     

    wait;
  end process;
  
end behavior;
