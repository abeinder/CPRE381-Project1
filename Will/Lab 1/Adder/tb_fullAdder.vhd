-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_fullAdder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the 2-1 mux unit.
--              
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
entity tb_fullAdder is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_fullAdder;

architecture mixed of tb_fullAdder is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
component fullAdder is
    port(
        i_X     : in std_logic;
        i_Y     : in std_logic;
        i_C     : in std_logic;
        o_S     : out std_logic;
        o_C     : out std_logic);
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

-- TODO: change input and output signals as needed.
signal s_iX   : std_logic := '0';
signal s_iY   : std_logic := '0';
signal s_iC   : std_logic := '0';
signal s_S   : std_logic;
signal s_C   : std_logic;


begin

  DUT0: fullAdder
  port map(
            i_X        => s_iX,
            i_Y        => s_iY,
            i_C         => s_iC,
            o_S         => s_S,
            o_C         => s_C);


  
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  -- This process resets the sequential components of the design.
  -- It is held to be 1 across both the negative and positive edges of the clock
  -- so it works regardless of whether the design uses synchronous (pos or neg edge)
  -- or asynchronous resets.
  P_RST: process
  begin
  	reset <= '0';   
    wait for gCLK_HPER/2;
	reset <= '1';
    wait for gCLK_HPER*2;
	reset <= '0';
	wait;
  end process;  
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

    s_iX    <= '0';
    s_iY    <= '0';
    s_iC    <= '0';

    wait for gCLK_HPER*2;

    s_iX    <= '1';
    s_iY    <= '0';
    s_iC    <= '0';    

    wait for gCLK_HPER*2;

    s_iX    <= '0';
    s_iY    <= '1';
    s_iC    <= '0';    

    wait for gCLK_HPER*2;

    s_iX    <= '1';
    s_iY    <= '1';
    s_iC    <= '0';    

    wait for gCLK_HPER*2;

    s_iX    <= '0';
    s_iY    <= '0';
    s_iC    <= '1';    

    wait for gCLK_HPER*2;
    
    s_iX    <= '1';
    s_iY    <= '0';
    s_iC    <= '1';    

    wait for gCLK_HPER*2;

    s_iX    <= '0';
    s_iY    <= '1';
    s_iC    <= '1';    

    wait for gCLK_HPER*2;

    s_iX    <= '1';
    s_iY    <= '1';
    s_iC    <= '1';    

    wait for gCLK_HPER*2;



    -- TODO: add test cases as needed (at least 3 more for this lab)
  end process;

end mixed;
