-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux_32to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 32:1 bit mux.
--
--


-- 02/10/22 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_32to1 is
  port(
       iA               : in std_logic_vector(32-1 downto 0);
       iSel             : in std_logic_vector(5-1 downto 0);
       oC               : out std_logic);

end mux_32to1;

architecture structure of mux_32to1 is 

begin

  with iSel select oC <=
    iA(0) when "00000",
    iA(1) when "00001",
    iA(2) when "00010",
    iA(3) when "00011",

    iA(4) when "00100",
    iA(5) when "00101",
    iA(6) when "00110",
    iA(7) when "00111",


    iA(8) when "01000",
    iA(9) when "01001",
    iA(10) when "01010",
    iA(11) when "01011",

    iA(12) when "01100",
    iA(13) when "01101",
    iA(14) when "01110",
    iA(15) when "01111",



    iA(16) when "10000",
    iA(17) when "10001",
    iA(18) when "10010",
    iA(19) when "10011",

    iA(20) when "10100",
    iA(21) when "10101",
    iA(22) when "10110",
    iA(23) when "10111",


    iA(24) when "11000",
    iA(25) when "11001",
    iA(26) when "11010",
    iA(27) when "11011",

    iA(28) when "11100",
    iA(29) when "11101",
    iA(30) when "11110",
    iA(31) when "11111",
    iA(0) when others;

  
end structure;
