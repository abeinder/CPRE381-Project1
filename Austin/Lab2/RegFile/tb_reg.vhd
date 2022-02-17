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

entity tb_reg is
  generic(gCLK_HPER   : time := 10 ns); 
end tb_reg;

architecture mixed of tb_reg is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component Reg is
  generic(N : integer := 32); 
  port(iCLK             : in std_logic;
       iA               : in std_logic_vector(N-1 downto 0);
       iRst             : in std_logic;
       iWe              : in std_logic;
       oC               : out std_logic_vector(N-1 downto 0));

end component;

signal A : STD_LOGIC_VECTOR(4-1 downto 0) := "0000";
signal RST : std_logic := '0';
signal WE : std_logic := '0';
signal O : STD_LOGIC_VECTOR(4-1 downto 0);
signal CLK : std_logic := '0';

begin

  DUT0: Reg
  
    generic map (N => 4)
    port map(
      iCLK             => CLK,
      iA               => A,
      iRst             => RST,
      iWe              => WE,
      oC               => O);

  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER*2;

    ----------------------------------------------
    -- Test case 1:
    -- 2 random 4 bit integers, S=0
    CLK           <= '1';
    wait for gCLK_HPER;
    A             <= "0011";
    RST           <= '0';
    WE            <= '1';
    wait for gCLK_HPER*2;

    CLK           <= '0';
    wait for gCLK_HPER*2;
    
    CLK           <= '1';
    wait for gCLK_HPER*2;

    CLK           <= '0';
    wait for gCLK_HPER*2;

    -- Test case 1:
    -- 2 random 4 bit integers, S=0
    CLK           <= '1';
    wait for gCLK_HPER;
    A             <= "1111";
    RST           <= '0';
    WE            <= '1';
    wait for gCLK_HPER*2;
    
    CLK           <= '0';
    wait for gCLK_HPER*2;
    
    CLK           <= '1';
    wait for gCLK_HPER*2;

    CLK           <= '0';
    wait for gCLK_HPER*2;

    -- Test case 1:
    -- 2 random 4 bit integers, S=0
    CLK           <= '1';
    wait for gCLK_HPER;
    A             <= "0000";
    RST           <= '0';
    WE            <= '1';
    wait for gCLK_HPER*2;
    
    CLK           <= '0';
    wait for gCLK_HPER*2;
    
    CLK           <= '1';
    wait for gCLK_HPER*2;

    CLK           <= '0';
    wait for gCLK_HPER*2;

    -- Test case 1:
    -- 2 random 4 bit integers, S=0
    CLK           <= '1';
    wait for gCLK_HPER;
    A             <= "0101";
    RST           <= '0';
    WE            <= '1';
    wait for gCLK_HPER*2;
    
    CLK           <= '0';
    wait for gCLK_HPER*2;
    
    CLK           <= '1';
    wait for gCLK_HPER*2;

    CLK           <= '0';
    wait for gCLK_HPER*2;

    end process;

end mixed;
