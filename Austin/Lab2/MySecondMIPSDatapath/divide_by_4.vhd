-------------------------------------------------------------------------
-- Austin Beinder
-- Iowa State University
-------------------------------------------------------------------------


-- processor_datapath2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the second MIPS datapath
--
--
-- NOTES:
-- 2/15/22 Austin Beinder::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity divide_by_4 is
    port(
        imm               : in std_logic_vector(16-1 downto 0); -- immediate input
        divide            : in std_logic; -- should divide by 4?
        o                : out std_logic_vector(16-1 downto 0)  
    );
end divide_by_4;

architecture structure of divide_by_4 is


    -- Internal Signals
    signal divided_output : STD_LOGIC_VECTOR(16-1 downto 0);


    signal zero_extend : std_logic_vector(16-1 downto 0);
    signal ones_extend : std_logic_vector(16-1 downto 0);
    signal should_ones_extend : std_logic;

    begin 
        
        zero_extend <= "00" & imm(16-1 downto 2);
        ones_extend <= "11" & imm(16-1 downto 2);

        -- if iSel is 0, or i_A(0) is 0, oC <= zero_extend
        -- else oC <= ones_extend
        should_ones_extend <= divide AND imm(15);

        with should_ones_extend select divided_output <=
        zero_extend when '0',
        ones_extend when '1',
        zero_extend when others;

        with divide select o <=
        divided_output when '1',
        imm when '0',
        imm when others;

        
    
    end structure;
