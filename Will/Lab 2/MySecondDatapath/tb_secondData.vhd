-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_secondData.vhd
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


entity tb_secondData is
  generic(gCLK_HPER   : time := 50 ns);
end tb_secondData;

architecture behavior of tb_secondData is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  --constant n : integer :=16;

  component secondData is
    port(i_CLK         : in std_logic;
          i_RS         : in std_logic_vector(4 downto 0);
          i_RT         : in std_logic_vector(4 downto 0);
          i_RD         : in std_logic_vector(4 downto 0);
          i_nAddSub    : in std_logic;
          i_ALUSrc     : in std_logic;
          i_ALU_MEM    : in std_logic;
          i_WE_M       : in std_logic;
          i_WE_R       : in std_logic;
          i_RST        : in std_logic;
          i_I          : in std_logic_vector(15 downto 0));
  
  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK : std_logic;
  signal s_WE_M : std_logic := '0';
  signal s_WE_R : std_logic := '0';
  signal s_RST : std_logic := '1';
  signal s_ALU_MEM : std_logic := '0';
  signal s_nAddSub : std_logic := '0';
  signal s_ALUSrc : std_logic := '0';
  signal s_I : std_logic_vector(15 downto 0) := 16x"0";
  --signal s_O : std_logic_vector(31 downto 0);
  signal s_RS : std_logic_vector(4 downto 0) := 5x"0";
  signal s_RT : std_logic_vector(4 downto 0) := 5x"0";
  signal s_RD : std_logic_vector(4 downto 0) := 5x"0";

begin

  DUT: secondData 
  port map(i_CLK => s_CLK,
           i_nAddSub => s_nAddSub,
           i_ALUSrc => s_ALUSrc,

           i_WE_M => s_WE_M,
           i_WE_R => s_WE_R,
           i_RST => s_RST,
           i_ALU_MEM => s_ALU_MEM,

           i_I => s_I,

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
    --addi 25 0 0
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"0";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"19";
    

    wait for cCLK_PER;


    wait for cCLK_PER;
    --addi 26 0 256
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"100";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"1a";
    

    wait for cCLK_PER;
    --lw 0 25
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '1';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"0";

    s_RS <= 5x"19";
    s_RT <= 5x"0";
    s_RD <= 5x"1";
    

    wait for cCLK_PER;
    --lw 2 4 25
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '1';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"4";

    s_RS <= 5x"19";
    s_RT <= 5x"0";
    s_RD <= 5x"2";
    

    wait for cCLK_PER;
    --add 1 1 2
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '0';

    s_I <= 16x"0";

    s_RS <= 5x"1";
    s_RT <= 5x"2";
    s_RD <= 5x"1";
    
    
    wait for cCLK_PER;
    --sw 1 26
    s_WE_R <= '0';
    s_WE_M <= '1';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"0";

    s_RS <= 5x"1a";
    s_RT <= 5x"1";
    s_RD <= 5x"0";
    

    wait for cCLK_PER;
    --lw 1 8 25
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '1';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"8";

    s_RS <= 5x"19";
    s_RT <= 5x"0";
    s_RD <= 5x"2";
    

    wait for cCLK_PER;
    --add 1 1 2
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '0';

    s_I <= 16x"0";

    s_RS <= 5x"1";
    s_RT <= 5x"2";
    s_RD <= 5x"1";
    

    wait for cCLK_PER;

    --sw 1 4 26
    s_WE_R <= '0';
    s_WE_M <= '1';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"4";

    s_RS <= 5x"1a";
    s_RT <= 5x"1";
    s_RD <= 5x"0";
    

    wait for cCLK_PER;
     
    --lw 1 12 26
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '1';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"c";

    s_RS <= 5x"19";
    s_RT <= 5x"0";
    s_RD <= 5x"2";
    

    wait for cCLK_PER;

    --add 1 1 2
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '0';

    s_I <= 16x"0";

    s_RS <= 5x"1";
    s_RT <= 5x"2";
    s_RD <= 5x"1";
    

    wait for cCLK_PER;

    --sw 1 8 26
    s_WE_R <= '0';
    s_WE_M <= '1';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"8";

    s_RS <= 5x"1a";
    s_RT <= 5x"1";
    s_RD <= 5x"0";
    

    wait for cCLK_PER;

    --lw 1 16 26
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '1';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"10";

    s_RS <= 5x"19";
    s_RT <= 5x"0";
    s_RD <= 5x"2";
    

    wait for cCLK_PER;

    --add 1 1 2
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '0';

    s_I <= 16x"0";

    s_RS <= 5x"1";
    s_RT <= 5x"2";
    s_RD <= 5x"1";
    

    wait for cCLK_PER;

    --sw 1 12 26
    s_WE_R <= '0';
    s_WE_M <= '1';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"c";

    s_RS <= 5x"1a";
    s_RT <= 5x"1";
    s_RD <= 5x"0";
    

    wait for cCLK_PER;

    --lw 1 20 26
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '1';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"14";

    s_RS <= 5x"19";
    s_RT <= 5x"0";
    s_RD <= 5x"2";
    

    wait for cCLK_PER;

    --add 1 1 2
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '0';

    s_I <= 16x"0";

    s_RS <= 5x"1";
    s_RT <= 5x"2";
    s_RD <= 5x"1";
    

    wait for cCLK_PER;

    --sw 1 16 26
    s_WE_R <= '0';
    s_WE_M <= '1';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"10";

    s_RS <= 5x"1a";
    s_RT <= 5x"1";
    s_RD <= 5x"0";
    

    wait for cCLK_PER;

    --lw 1 24 26
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '1';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"18";

    s_RS <= 5x"19";
    s_RT <= 5x"0";
    s_RD <= 5x"2";
    

    wait for cCLK_PER;

    --add 1 1 2
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '0';

    s_I <= 16x"0";

    s_RS <= 5x"1";
    s_RT <= 5x"2";
    s_RD <= 5x"1";
    

    wait for cCLK_PER;

    --addi 27 0 512
    s_WE_R <= '1';
    s_WE_M <= '0';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"200";

    s_RS <= 5x"0";
    s_RT <= 5x"0";
    s_RD <= 5x"1B";
    

    wait for cCLK_PER;

    --sw 1 16 26
    s_WE_R <= '0';
    s_WE_M <= '1';
    s_ALU_MEM <= '0';

    s_nAddSub <= '0';
    s_ALUSrc <= '1';

    s_I <= 16x"FFFC";

    s_RS <= 5x"1b";
    s_RT <= 5x"1";
    s_RD <= 5x"0";
    

    wait for cCLK_PER;


    wait;
  end process;
  
end behavior;
