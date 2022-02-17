-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_dmem.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the memory
--              
-- 2/14/2022 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_dmem is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_dmem;

architecture mixed of tb_dmem is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;


component mem is

	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);

	port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal imm : STD_LOGIC_VECTOR(32-1 downto 0) := 32x"00000000";

signal o1, o2, o3, o4, o5, o6, o7, o8, o9, o10 : STD_LOGIC_VECTOR(32-1 downto 0);
signal out1 : STD_LOGIC_VECTOR(32-1 downto 0);
signal addr : STD_LOGIC_VECTOR(10-1 downto 0) := 10x"000";
signal wrt, clk  : std_logic := '1';

begin

  dmem: mem
    generic map(
      DATA_WIDTH  => 32,
      ADDR_WIDTH  => 10
    )
    port map (
		clk		=> clk,
		addr	=> addr,
		data	=> imm,
		we		=> wrt,
		q		  => out1
	);
  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER; 
    --------------------------------------- Read Values ---------
    
    clk <= '0';

    wait for gCLK_HPER;
    wrt <= '0';
    addr <= 10x"000";

    wait for gCLK_HPER;
    clk <= '1';

    o1 <= out1;
    ----------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"001";

    wait for gCLK_HPER*2;
    clk <= '1';

    o2 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"002";

    wait for gCLK_HPER*2;
    clk <= '1';

    o3 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"003";

    wait for gCLK_HPER*2;
    clk <= '1';

    o4 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"004";

    wait for gCLK_HPER*2;
    clk <= '1';

    o5 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"005";

    wait for gCLK_HPER*2;
    clk <= '1';

    o6 <= out1;
    --------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"006";

    wait for gCLK_HPER*2;
    clk <= '1';

    o7 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"007";

    wait for gCLK_HPER*2;
    clk <= '1';

    o8 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"008";

    wait for gCLK_HPER*2;
    clk <= '1';

    o9 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"009";

    wait for gCLK_HPER*2;
    clk <= '1';

    o10 <= out1;
    ------------------------------------------ Write Values ---------------
    
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '1';
    imm <= o1;
    addr <= 10x"100";

    wait for gCLK_HPER*2;
    clk <= '1';

    o1 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    imm <= o2;
    addr <= 10x"101";

    wait for gCLK_HPER*2;
    clk <= '1';

    o2 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    imm <= o3;
    addr <= 10x"102";

    wait for gCLK_HPER*2;
    clk <= '1';

    o3 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    imm <= o4;
    addr <= 10x"103";

    wait for gCLK_HPER*2;
    clk <= '1';

    o4 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    imm <= o5;
    addr <= 10x"104";

    wait for gCLK_HPER*2;
    clk <= '1';

    o5 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    imm <= o6;
    addr <= 10x"105";

    wait for gCLK_HPER*2;
    clk <= '1';

    o6 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    imm <= o7;
    addr <= 10x"106";

    wait for gCLK_HPER*2;
    clk <= '1';

    o7 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    imm <= o8;
    addr <= 10x"107";

    wait for gCLK_HPER*2;
    clk <= '1';

    o8 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    imm <= o9;
    addr <= 10x"108";

    wait for gCLK_HPER*2;
    clk <= '1';

    o9 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    imm <= o10;
    addr <= 10x"109";

    wait for gCLK_HPER*2;
    clk <= '1';

    o10 <= out1;
    ---------------------
    ------------------------------------------ Reread Values ---------------
    clk <= '0';

    wait for gCLK_HPER;
    wrt <= '0';
    addr <= 10x"100";

    wait for gCLK_HPER;
    clk <= '1';

    o1 <= out1;
    ----------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"101";

    wait for gCLK_HPER*2;
    clk <= '1';

    o2 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"102";

    wait for gCLK_HPER*2;
    clk <= '1';

    o3 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"103";

    wait for gCLK_HPER*2;
    clk <= '1';

    o4 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"104";

    wait for gCLK_HPER*2;
    clk <= '1';

    o5 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"105";

    wait for gCLK_HPER*2;
    clk <= '1';

    o6 <= out1;
    --------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"106";

    wait for gCLK_HPER*2;
    clk <= '1';

    o7 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"107";

    wait for gCLK_HPER*2;
    clk <= '1';

    o8 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"108";

    wait for gCLK_HPER*2;
    clk <= '1';

    o9 <= out1;
    ---------------------
    wait for gCLK_HPER*2;
    clk <= '0';
    addr <= 10x"109";

    wait for gCLK_HPER*2;
    clk <= '1';

    o10 <= out1;

  end process;

end mixed;
