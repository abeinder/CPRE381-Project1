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
entity tb_processor_datapath2 is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_processor_datapath2;

architecture mixed of tb_processor_datapath2 is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;


component processor_datapath2 is
  port(
    imm               : in std_logic_vector(16-1 downto 0); -- immediate input
    rd                : in std_logic_vector(5-1 downto 0); -- register write address
    rs                : in std_logic_vector(5-1 downto 0); -- reg read address 0
    rt                : in std_logic_vector(5-1 downto 0); -- reg read address 1

    iClk              : in std_logic;

    iRst              : in std_logic; -- clear all regs?

    idivide_by_4      : in std_logic; -- should the immediate value be divided by 4 to help offset?
    isign_unsigned    : in std_logic; -- immediate value signed or unsigned?
    imem_or_alu       : in std_logic; -- reg file input from memory or from add sub
    iwrite_mem        : in std_logic; -- write on memory
    iwrite            : in std_logic; -- write on registers
    nAdd_Sub          : in std_logic; -- add or subtract
    ALUsrc            : in std_logic; -- register or immediate

    o0                : out std_logic_vector(32-1 downto 0); -- read output 0
    o1                : out std_logic_vector(32-1 downto 0)  -- read output 1
);
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal imm : STD_LOGIC_VECTOR(16-1 downto 0) := 16x"0000";
signal dst, src1, src2 : STD_LOGIC_VECTOR(5-1 downto 0) := "00000";
signal wrt, write_mem, addsub, alusrc, divide_by_4, mem_or_alu, sign_unsign : std_logic := '0';
signal rst, clk : std_logic := '0';
signal O0, O1 : STD_LOGIC_VECTOR(32-1 downto 0);
signal test_case_number : integer;

begin

  DUT0: processor_datapath2
    port map(
      imm               => imm,
      rd                => dst,
      rs                => src1,
      rt                => src2,
  
      iClk              => clk,
  
      iRst              => rst,
  
      idivide_by_4      => divide_by_4,
      isign_unsigned    => sign_unsign,
      imem_or_alu       => mem_or_alu,
      iwrite_mem        => write_mem,
      iwrite            => wrt, 
      nAdd_Sub          => addsub,
      ALUsrc            => alusrc,
  
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

    -- Test case 1: addi $25, $0, 0
    wait for gCLK_HPER;
    test_case_number <= 1;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '0';
    mem_or_alu  <= '0';
    sign_unsign <= '0';

    dst <= 5x"19";
    src1 <= 5x"00";
    src2 <= 5x"00";
    imm <= 16x"0000";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    src2 <= 5x"19"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;

    clk <= '0';
    wait for gCLK_HPER;

    -- Test case 2: addi $26, $0, 256
    wait for gCLK_HPER;
    test_case_number <= 2;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '0';
    mem_or_alu  <= '0';
    sign_unsign <= '0';

    dst <= 5x"1A";
    src1 <= 5x"00";
    src2 <= 5x"00";
    imm <= 16x"0100";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"1A"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;

    -- Test case 3: lw $1, 0($25) 
    wait for gCLK_HPER;
    test_case_number <= 3;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"01";
    src1 <= 5x"19";
    src2 <= 5x"00";
    imm <= 16x"0000";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;

    -- Test case 4: lw $2, 4($25) 
    wait for gCLK_HPER;
    test_case_number <= 4;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"02";
    src1 <= 5x"19";
    src2 <= 5x"02";
    imm <= 16x"0004";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"02"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;

    -- Test case 5: add $1, $1, $2 
    wait for gCLK_HPER;
    test_case_number <= 5;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '0';
    divide_by_4 <= '0';
    mem_or_alu  <= '0';
    sign_unsign <= '0';

    dst <= 5x"01";
    src1 <= 5x"01";
    src2 <= 5x"02";
    imm <= 16x"0000";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 6: sw $1, 0($26)  
    wait for gCLK_HPER;
    test_case_number <= 6;
    wrt         <= '0';
    write_mem   <= '1';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"00";
    src1 <= 5x"1A";
    src2 <= 5x"01";
    imm <= 16x"0000";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';

    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 7: lw $2, 8($25) 
    wait for gCLK_HPER;
    test_case_number <= 7;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"02";
    src1 <= 5x"19";
    src2 <= 5x"02";
    imm <= 16x"0008";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"02"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 8: add $1, $1, $2
    wait for gCLK_HPER;
    test_case_number <= 8;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '0';
    divide_by_4 <= '0';
    mem_or_alu  <= '0';
    sign_unsign <= '0';

    dst <= 5x"01";
    src1 <= 5x"01";
    src2 <= 5x"02";
    imm <= 16x"0000";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 9: sw $1, 4($26) 
    wait for gCLK_HPER;
    test_case_number <= 9;
    wrt         <= '0';
    write_mem   <= '1';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"00";
    src1 <= 5x"1A";
    src2 <= 5x"01";
    imm <= 16x"0004";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';

    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 10: lw $2, 12($25)
    wait for gCLK_HPER;
    test_case_number <= 10;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"02";
    src1 <= 5x"19";
    src2 <= 5x"02";
    imm <= 16x"000C";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"02"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;



    -- Test case 11: add $1, $1, $2 
    wait for gCLK_HPER;
    test_case_number <= 11;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '0';
    divide_by_4 <= '0';
    mem_or_alu  <= '0';
    sign_unsign <= '0';

    dst <= 5x"01";
    src1 <= 5x"01";
    src2 <= 5x"02";
    imm <= 16x"0000";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 12: sw $1, 8($26) 
    wait for gCLK_HPER;
    test_case_number <= 12;
    wrt         <= '0';
    write_mem   <= '1';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"00";
    src1 <= 5x"1A";
    src2 <= 5x"01";
    imm <= 16x"0008";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';

    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 13: lw $2, 16($25)
    wait for gCLK_HPER;
    test_case_number <= 13;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"02";
    src1 <= 5x"19";
    src2 <= 5x"02";
    imm <= 16x"0010";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"02"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;

    -- Test case 14: add $1, $1, $2
    wait for gCLK_HPER;
    test_case_number <= 14;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '0';
    divide_by_4 <= '0';
    mem_or_alu  <= '0';
    sign_unsign <= '0';

    dst <= 5x"01";
    src1 <= 5x"01";
    src2 <= 5x"02";
    imm <= 16x"0000";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 15: sw $1, 12($26) ---
    wait for gCLK_HPER;
    test_case_number <= 15;
    wrt         <= '0';
    write_mem   <= '1';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"00";
    src1 <= 5x"1A";
    src2 <= 5x"01";
    imm <= 16x"000C";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';

    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 16: lw $2, 20($25) 
    test_case_number <= 16;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"02";
    src1 <= 5x"19";
    src2 <= 5x"02";
    imm <= 16x"0014";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"02"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 17: add $1, $1, $2
    wait for gCLK_HPER;
    test_case_number <= 17;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '0';
    divide_by_4 <= '0';
    mem_or_alu  <= '0';
    sign_unsign <= '0';

    dst <= 5x"01";
    src1 <= 5x"01";
    src2 <= 5x"02";
    imm <= 16x"0000";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 18: sw $1, 16($26)
    wait for gCLK_HPER;
    test_case_number <= 18;
    wrt         <= '0';
    write_mem   <= '1';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"00";
    src1 <= 5x"1A";
    src2 <= 5x"01";
    imm <= 16x"0010";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';

    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 19: lw $2, 24($25)
    test_case_number <= 19;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"02";
    src1 <= 5x"19";
    src2 <= 5x"02";
    imm <= 16x"0018";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"02"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 20: add $1, $1, $2 
    wait for gCLK_HPER;
    test_case_number <= 20;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '0';
    divide_by_4 <= '0';
    mem_or_alu  <= '0';
    sign_unsign <= '0';

    dst <= 5x"01";
    src1 <= 5x"01";
    src2 <= 5x"02";
    imm <= 16x"0000";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"01"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 21: addi $27, $0, 512
    wait for gCLK_HPER;
    test_case_number <= 21;
    wrt         <= '1';
    write_mem   <= '0';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '0';
    mem_or_alu  <= '0';
    sign_unsign <= '0';

    dst <= 5x"1B";
    src1 <= 5x"00";
    src2 <= 5x"1B";
    imm <= 16x"0200";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';
    wrt <= '0';
    src2 <= 5x"1B"; -- Expect this to read 0

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    -- Test case 22: sw $1, -4($27)
    wait for gCLK_HPER;
    test_case_number <= 22;
    wrt         <= '0';
    write_mem   <= '1';
    addsub      <= '0';
    alusrc      <= '1';
    divide_by_4 <= '1';
    mem_or_alu  <= '1';
    sign_unsign <= '0';

    dst <= 5x"00";
    src1 <= 5x"1B";
    src2 <= 5x"01";
    imm <= 16x"FFFC";
    wait for gCLK_HPER;

    clk <= '1';
    wait for gCLK_HPER*2;
    clk <= '0';

    wait for gCLK_HPER*2;
    clk <= '1';
    wait for gCLK_HPER*2;
    
    clk <= '0';
    wait for gCLK_HPER;


    

    
    end process;

end mixed;
