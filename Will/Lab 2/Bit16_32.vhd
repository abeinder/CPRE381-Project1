-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Bit16_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide register
-- using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 1/6/20 by H3::Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.my_array.all;

entity Bit16_32 is
  port( i_A          : in std_logic_vector(15 downto 0);
        i_S          : in std_logic;
        o_O          : out  std_logic_vector(31 downto 0));

end Bit16_32;

architecture dataflow of Bit16_32 is
  begin
        with i_S select
        o_O <= std_logic_vector(resize(signed(i_A), 32)) when '1',
               std_logic_vector(resize(unsigned(i_A), 32)) when others;

        



--   signal temp : std_logic_vector(31 downto 0);
--   signal temp2 : std_logic_vector(31 downto 0);

--   begin
  
--     with i_A(15) select
--     temp <= x"FFFF0000" when '1',
--             x"00000000" when others;

--     with i_S select
--     temp2 <= temp when '1',
--             x"00000000" when others;

--     o_O <= temp2 or i_A(31 downto 0);
    
  end dataflow;
  
