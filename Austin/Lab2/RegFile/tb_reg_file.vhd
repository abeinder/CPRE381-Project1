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

entity tb_reg_file is
  generic(gCLK_HPER   : time := 10 ns); 
end tb_reg_file;

architecture mixed of tb_reg_file is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component reg_file32 is
    port(
         iA               : in std_logic_vector(32-1 downto 0);
         iDest            : in std_logic_vector(5-1 downto 0);
         iwrite          : in std_logic;
         iRd0            : in std_logic_vector(5-1 downto 0);
         iRd1            : in std_logic_vector(5-1 downto 0);
         iRst             : in std_logic;
         iClk             : in std_logic;
         o0               : out std_logic_vector(32-1 downto 0);
         o1               : out std_logic_vector(32-1 downto 0)
      );
  
  end component;

signal A : STD_LOGIC_VECTOR(32-1 downto 0) := 32x"00000000";
signal Dest : STD_LOGIC_VECTOR(5-1 downto 0) := "00000";
signal writeEn : std_logic := '1';
signal Rd0 : STD_LOGIC_VECTOR(5-1 downto 0) := "00000";
signal Rd1 : STD_LOGIC_VECTOR(5-1 downto 0) := "00000";
signal O0, O1 : STD_LOGIC_VECTOR(32-1 downto 0);
signal CLK : std_logic := '0';
signal Rst : std_logic := '0';
begin


    DUT0: reg_file32
    port map(
            iA               => A,
            iDest            => Dest,
            iwrite          => writeEn,
            iRd0            => Rd0,
            iRd1            => Rd1,
            iRst            => Rst,
            iClk            => CLK,
            o0              => O0,
            o1              => O1
        );
      

  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER*2;

    ----------------------------------------------
    -- Test case 1:
      CLK           <= '1';
      wait for gCLK_HPER;
      A                  <= 32x"000000002";
      Dest               <= "00000";
      Rd0                <= "00000";
      Rd1                <= "00001";
      wait for gCLK_HPER*2;

      CLK           <= '0';
      wait for gCLK_HPER*2;
      CLK           <= '1';
      wait for gCLK_HPER*2;
      CLK           <= '0';
      wait for gCLK_HPER*2;
    
    -- Test case 2:
      CLK           <= '1';
      wait for gCLK_HPER;
      A                  <= 32x"00000000F";
      Dest               <= "00100";
      Rd0                <= "00100";
      Rd1                <= "00000";
      wait for gCLK_HPER*2;

      CLK           <= '0';
      wait for gCLK_HPER*2;
      CLK           <= '1';
      wait for gCLK_HPER*2;
      CLK           <= '0';
      wait for gCLK_HPER*2;

      -- Test case 3:
      CLK           <= '1';
      wait for gCLK_HPER;
      A                  <= 32x"00000000D";
      Dest               <= "11111";
      Rd0                <= "00010";
      Rd1                <= "00000";
      wait for gCLK_HPER*2;

      CLK           <= '0';
      wait for gCLK_HPER*2;
      CLK           <= '1';
      wait for gCLK_HPER*2;
      CLK           <= '0';
      wait for gCLK_HPER*2;

      -- Test case 4:
      CLK           <= '1';
      wait for gCLK_HPER;
      A                  <= 32x"000000005";
      Dest               <= "00010";
      Rd0                <= "11111";
      Rd1                <= "00000";
      wait for gCLK_HPER*2;

      CLK           <= '0';
      wait for gCLK_HPER*2;
      CLK           <= '1';
      wait for gCLK_HPER*2;
      CLK           <= '0';
      wait for gCLK_HPER*2;

      -- Test case 5:
      CLK           <= '1';
      wait for gCLK_HPER;
      writeEn            <= '0';
      A                  <= 32x"000000004";
      Dest               <= "00010";
      Rd0                <= "11111";
      Rd1                <= "00000";
      wait for gCLK_HPER*2;

      CLK           <= '0';
      wait for gCLK_HPER*2;
      CLK           <= '1';
      wait for gCLK_HPER*2;
      CLK           <= '0';
      wait for gCLK_HPER*2;


    end process;

end mixed;
