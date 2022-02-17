-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_firstData.vhd
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


entity tb_firstData is
  generic(gCLK_HPER   : time := 50 ns);
end tb_firstData;

architecture behavior of tb_firstData is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  --constant n : integer :=16;

  component firstData is
    port(i_CLK         : in std_logic;
          i_RS         : in std_logic_vector(4 downto 0);
          i_RT         : in std_logic_vector(4 downto 0);
          i_RD         : in std_logic_vector(4 downto 0);
          i_nAddSub    : in std_logic;
          i_ALUSrc     : in std_logic;
          i_RST        : in std_logic;
          i_WE         : in std_logic;
          i_I          : in std_logic_vector(31 downto 0));
          --o_Q          : out std_logic_vector(31 downto 0));
  
  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK : std_logic;
  signal s_WE : std_logic := '0';
  signal s_RST : std_logic := '1';
  signal s_nAddSub : std_logic := '0';
  signal s_ALUSrc : std_logic := '0';
  signal s_I : std_logic_vector(31 downto 0) := 32x"0";
  signal s_O : std_logic_vector(31 downto 0);
  signal s_RS : std_logic_vector(4 downto 0) := 5x"0";
  signal s_RT : std_logic_vector(4 downto 0) := 5x"0";
  signal s_RD : std_logic_vector(4 downto 0) := 5x"0";

begin

  DUT: firstData 
  port map(i_CLK => s_CLK,
           i_nAddSub => s_nAddSub,
           i_ALUSrc => s_ALUSrc,

           i_WE => s_WE,
           i_RST => s_RST,

           i_I => s_I,
           --o_Q => s_O,

           i_RS => s_RS,
           i_RT => s_RT,
           i_RD => s_RD);

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

    s_RST <= '0';

    wait for cCLK_PER;

    s_WE <= '1';
    s_nAddSub <= '0';

    s_ALUSrc <= '1';
    s_I <= 32x"1";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"1";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '1';
    s_I <= 32x"2";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"2";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '1';
    s_I <= 32x"3";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"3";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '1';
    s_I <= 32x"4";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"4";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '1';
    s_I <= 32x"5";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"5";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '1';
    s_I <= 32x"6";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"6";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '1';
    s_I <= 32x"7";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"7";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '1';
    s_I <= 32x"8";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"8";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '1';
    s_I <= 32x"9";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"9";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '1';
    s_I <= 32x"a";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"a";
    
    --11

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '0';
    s_I <= 32x"0";

    s_RS <= 5x"1";
    s_RT <= 5x"2";
    s_RD <= 5x"b";
    

    wait for cCLK_PER;

    s_nAddSub <= '1';

    s_ALUSrc <= '0';
    s_I <= 32x"0";

    s_RS <= 5x"b";
    s_RT <= 5x"3";
    s_RD <= 5x"c";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '0';
    s_I <= 32x"0";

    s_RS <= 5x"c";
    s_RT <= 5x"4";
    s_RD <= 5x"d";
    

    wait for cCLK_PER;

    --14

    s_nAddSub <= '1';

    s_ALUSrc <= '0';
    s_I <= 32x"0";

    s_RS <= 5x"d";
    s_RT <= 5x"5";
    s_RD <= 5x"e";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '0';
    s_I <= 32x"0";

    s_RS <= 5x"e";
    s_RT <= 5x"6";
    s_RD <= 5x"f";
    

    wait for cCLK_PER;

    s_nAddSub <= '1';

    s_ALUSrc <= '0';
    s_I <= 32x"0";

    s_RS <= 5x"f";
    s_RT <= 5x"7";
    s_RD <= 5x"10";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '0';
    s_I <= 32x"0";

    s_RS <= 5x"10";
    s_RT <= 5x"8";
    s_RD <= 5x"11";
    

    wait for cCLK_PER;


    s_nAddSub <= '1';

    s_ALUSrc <= '0';
    s_I <= 32x"0";

    s_RS <= 5x"11";
    s_RT <= 5x"9";
    s_RD <= 5x"12";
    

    wait for cCLK_PER;

    
    s_nAddSub <= '0';

    s_ALUSrc <= '0';
    s_I <= 32x"0";

    s_RS <= 5x"12";
    s_RT <= 5x"a";
    s_RD <= 5x"13";
    

    wait for cCLK_PER;


    s_nAddSub <= '1';

    s_ALUSrc <= '1';
    s_I <= 32x"23";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"14";
    

    wait for cCLK_PER;

    s_nAddSub <= '0';

    s_ALUSrc <= '0';
    s_I <= 32x"0";

    s_RS <= 5x"13";
    s_RT <= 5x"14";
    s_RD <= 5x"15";
    

    wait for cCLK_PER;
  

     

    wait;
  end process;
  
end behavior;
