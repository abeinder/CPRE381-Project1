-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux_32_32to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 32bit 32:1 32 bit mux.
--
--


-- 02/10/22 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity bit_width_extender_16to32 is
  port(
       i_A              : in std_logic_vector(16-1 downto 0);
       iSel             : in std_logic; -- if 0, 0 extend, else sign extend
       oC               : out std_logic_vector(32-1 downto 0)
    );

end bit_width_extender_16to32;

architecture structure of bit_width_extender_16to32 is 

signal zero_extend : std_logic_vector(32-1 downto 0);
signal ones_extend : std_logic_vector(32-1 downto 0);
signal should_ones_extend : std_logic;

begin

    zero_extend <= 16x"0000" & i_A;
    ones_extend <= 16x"FFFF" & i_A;

    -- if iSel is 0, or i_A(0) is 0, oC <= zero_extend
    -- else oC <= ones_extend
    should_ones_extend <= iSel AND i_A(15);

    with should_ones_extend select oC <=
    zero_extend when '0',
    ones_extend when '1',
    zero_extend when others;



end structure;
