-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_regFile.vhd
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


entity tb_regFile is
  generic(gCLK_HPER   : time := 50 ns);
end tb_regFile;

architecture behavior of tb_regFile is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  --constant n : integer :=16;

  component regFile is
    port(i_CLK         : in std_logic;
          i_S          : in std_logic_vector(4 downto 0);
          i_R1         : in std_logic_vector(4 downto 0);
          i_R2         : in std_logic_vector(4 downto 0);
          i_WE         : in std_logic;
          i_RST        : in std_logic;
          i_D          : in std_logic_vector(31 downto 0);
          o_Q1         : out std_logic_vector(31 downto 0);
          o_Q2         : out std_logic_vector(31 downto 0));
  
  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK : std_logic;
  signal s_WE : std_logic := '0';
  signal s_RST : std_logic := '0';
  signal s_I : std_logic_vector(31 downto 0) := 32x"0";
  signal s_O1 : std_logic_vector(31 downto 0);
  signal s_O2 : std_logic_vector(31 downto 0);
  signal s_SR1 : std_logic_vector(4 downto 0) := 5x"0";
  signal s_SR2 : std_logic_vector(4 downto 0) := 5x"0";
  signal s_SW : std_logic_vector(4 downto 0) := 5x"0";

begin

  DUT: regFile 
  port map(i_CLK => s_CLK,
           i_S => s_SW,
           i_R1 => s_SR1,
           i_R2 => s_SR2,
           i_WE => s_WE,
           i_RST => s_RST,
           i_D => s_I,
           o_Q1 => s_O1,
           o_Q2 => s_O2);

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

    s_RST <= '1';

    wait for cCLK_PER;

    s_RST <= '0';
    s_SW <= 5x"10";
    s_I <= 32x"FFF";
    s_SR1 <= 5x"2";
    s_SR2 <= 5x"5";
    

    wait for cCLK_PER;

    s_WE <= '1';

    wait for cCLK_PER;
    
    s_I <= 32x"222333";
    s_SW <= 5x"14";
    s_SR1 <= 5x"10";
    s_SR2 <= 5x"7";

    wait for cCLK_PER;

    s_WE <= '0';
    s_SW <= 5x"2";

    wait for cCLK_PER;

    s_SR1 <= 5x"14";
    s_SR2 <= 5x"10";

    wait for cCLK_PER;

    
    s_WE <= '1';
    s_SW <= 5x"0";

    wait for cCLK_PER;




  

     

    wait;
  end process;
  
end behavior;
