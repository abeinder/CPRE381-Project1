-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_processor_datapath1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the first datapath
--              
-- 2/13/2022 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_processor_datapath1 is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_processor_datapath1;

architecture mixed of tb_processor_datapath1 is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;


component processor_datapath1 is
    port(
        imm               : in std_logic_vector(32-1 downto 0); -- immediate input
        rd                : in std_logic_vector(5-1 downto 0); -- write address
        iwrite            : in std_logic;
        rs                : in std_logic_vector(5-1 downto 0); -- read address 0
        rt                : in std_logic_vector(5-1 downto 0); -- read address 1
        iRst              : in std_logic;
        iClk              : in std_logic;
        nAdd_Sub          : in std_logic;
        ALUsrc            : in std_logic;
        o0                : out std_logic_vector(32-1 downto 0); -- read output 0
        o1                : out std_logic_vector(32-1 downto 0)  -- read output 1
    );
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal imm : STD_LOGIC_VECTOR(32-1 downto 0) := 32x"00000000";
signal dst, src1, src2 : STD_LOGIC_VECTOR(5-1 downto 0) := "00000";
signal wrt, rst, clk, addsub, src  : std_logic := '0';
signal O0, O1 : STD_LOGIC_VECTOR(32-1 downto 0);
signal test_case_number : integer := 0;

begin

  DUT0: processor_datapath1
    port map(
        imm               => imm,
        rd                => dst,
        iwrite            => wrt,
        rs                => src1,
        rt                => src2,
        iRst              => rst,
        iClk              => clk,
        nAdd_Sub          => addsub,
        ALUsrc            => src,
        o0                => O0,
        o1                => O1
    );
  -- Assign inputs for each test case.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER; -- for waveform clarity, I prefer not to change inputs on clk edges
    ----------------------------------------------
    rst <= '0';
    clk <= '0';

    -- Test case 1: addi $1, $0, 1
    wait for gCLK_HPER;
    test_case_number <= 1;
    wrt <= '1';

    addsub <= '0';
    src <= '1';

    dst <= 5x"01";
    src1 <= 5x"00";
    imm <= 32x"00000001";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';

    src2 <= 5x"01"; -- can use this to get the O1 output

    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 2: addi $2, $0, 2
    wait for gCLK_HPER;
    test_case_number <= 2;

    dst <= 5x"02";
    src1 <= 5x"00";
    imm <= 32x"00000002";

    wait for gCLK_HPER*2;
    clk <= '0';

    src2 <= 5x"02"; -- can use this to get the O1 output

    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 3: addi $3, $0, 3
    wait for gCLK_HPER;
    test_case_number <= 3;

    dst <= 5x"03";
    src1 <= 5x"00";
    imm <= 32x"00000003";

    wait for gCLK_HPER*2;
    clk <= '0';

    src2 <= 5x"03"; -- can use this to get the O1 output

    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 4: addi $4, $0, 4
    wait for gCLK_HPER;
    test_case_number <= 4;

    dst <= 5x"04";
    src1 <= 5x"00";
    imm <= 32x"00000004";

    wait for gCLK_HPER*2;
    clk <= '0';

    src2 <= 5x"04"; -- can use this to get the O1 output

    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 5: addi $5, $0, 5
    wait for gCLK_HPER;
    test_case_number <= 5;

    dst <= 5x"05";
    src1 <= 5x"00";
    imm <= 32x"00000005";

    wait for gCLK_HPER*2;
    clk <= '0';
    src2 <= 5x"05"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 6: addi $6, $0, 6
    wait for gCLK_HPER;
    test_case_number <= 6;

    dst <= 5x"06";
    src1 <= 5x"00";
    imm <= 32x"00000006";

    wait for gCLK_HPER*2;
    clk <= '0';
    src2 <= 5x"06"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 7: addi $7, $0, 7
    wait for gCLK_HPER;
    test_case_number <= 7;

    dst <= 5x"07";
    src1 <= 5x"00";
    imm <= 32x"00000007";

    wait for gCLK_HPER*2;
    clk <= '0';
    src2 <= 5x"07"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    
        

    -- Test case 8: addi $8, $0, 8
    wait for gCLK_HPER;
    test_case_number <= 8;

    dst <= 5x"08";
    src1 <= 5x"00";
    imm <= 32x"00000008";

    wait for gCLK_HPER*2;
    clk <= '0';
    src2 <= 5x"08"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 9: addi $9, $0, 9
    wait for gCLK_HPER;
    test_case_number <= 9;

    dst <= 5x"09";
    src1 <= 5x"00";
    imm <= 32x"00000009";

    wait for gCLK_HPER*2;
    clk <= '0';
    src2 <= 5x"09"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 10: addi $10, $0, 10
    wait for gCLK_HPER;
    test_case_number <= 10;

    dst <= 5x"0A";
    src1 <= 5x"00";
    imm <= 32x"0000000A";

    wait for gCLK_HPER*2;
    clk <= '0';
    src2 <= 5x"0A"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';


    ------------------------ Non immediates --------------------------

    -- Test case 11: add $11, $1, $2
    wait for gCLK_HPER;
    test_case_number <= 11;
    wrt <= '1';

    addsub <= '0';
    src <= '0';

    dst <= 5x"0B";
    src1 <= 5x"01";
    src2 <= 5x"02";

    
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wrt <= '0';
    src2 <= 5x"0B"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 12: sub $12, $11, $3
    wait for gCLK_HPER;
    test_case_number <= 12;
    wrt <= '1';

    addsub <= '1';

    dst <= 5x"0C";
    src1 <= 5x"0B";
    src2 <= 5x"03";

    wait for gCLK_HPER*2;

    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wrt <= '0';
    src2 <= 5x"0C"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 13: add $13, $12, $4
    wait for gCLK_HPER;
    test_case_number <= 13;
    wrt <= '1';
    addsub <= '0';

    dst <= 5x"0D";
    src1 <= 5x"0C";
    src2 <= 5x"04";

    wait for gCLK_HPER*2;

    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wrt <= '0';
    src2 <= 5x"0D"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 14: sub $14, $13, $5
    wait for gCLK_HPER;
    test_case_number <= 14;
    wrt <= '1';
    addsub <= '1';

    dst <= 5x"0E";
    src1 <= 5x"0D";
    src2 <= 5x"05";

    wait for gCLK_HPER*2;

    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wrt <= '0';
    src2 <= 5x"0E"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 15: add $15, $14, $6
    wait for gCLK_HPER;
    test_case_number <= 15;
    wrt <= '1';
    addsub <= '0';

    dst <= 5x"0F";
    src1 <= 5x"0E";
    src2 <= 5x"06";

    wait for gCLK_HPER*2;

    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wrt <= '0';
    src2 <= 5x"0F"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 16: sub $16, $15, $7
    wait for gCLK_HPER;
    test_case_number <= 16;
    wrt <= '1';
    addsub <= '1';

    dst <= 5x"10";
    src1 <= 5x"0F";
    src2 <= 5x"07";

    wait for gCLK_HPER*2;

    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wrt <= '0';
    src2 <= 5x"10"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 17: add $17, $16, $8
    wait for gCLK_HPER;
    test_case_number <= 17;
    wrt <= '1';
    addsub <= '0';

    dst <= 5x"11";
    src1 <= 5x"10";
    src2 <= 5x"08";

    wait for gCLK_HPER*2;

    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wrt <= '0';
    src2 <= 5x"11"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 18: sub $18, $17, $9
    wait for gCLK_HPER;
    test_case_number <= 18;
    wrt <= '1';
    addsub <= '1';

    dst <= 5x"12";
    src1 <= 5x"11";
    src2 <= 5x"09";

    wait for gCLK_HPER*2;

    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wrt <= '0';
    src2 <= 5x"12"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 19: add $19, $18, $10
    wait for gCLK_HPER;
    test_case_number <= 19;
    wrt <= '1';
    addsub <= '0';

    dst <= 5x"13";
    src1 <= 5x"12";
    src2 <= 5x"0A";

    wait for gCLK_HPER*2;

    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wrt <= '0';
    src2 <= 5x"13"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 20: addi $20, $0, -35
    wait for gCLK_HPER;
    test_case_number <= 20;
    wrt <= '1';
    addsub <= '0';
    src <= '1';

    dst <= 5x"14";
    src1 <= 5x"0";
    imm <= 32x"FFFFFFDD";

    wait for gCLK_HPER*2;

    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wrt <= '0';
    src2 <= 5x"14"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';



    -- Test case 21: add $21, $19, $20
    wait for gCLK_HPER;
    test_case_number <= 21;
    wrt <= '1';
    addsub <= '0';
    src <= '0';

    dst <= 5x"15";
    src1 <= 5x"13";
    src2 <= 5x"14";

    wait for gCLK_HPER*2;

    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wrt <= '0';
    src2 <= 5x"15"; -- can use this to get the O1 output
    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wait for gCLK_HPER*2;
    clk <= '1';

    
    end process;

end mixed;
