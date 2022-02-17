-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- decoder_5to32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 5:32 bit decoder.
--
--


-- 02/10/22 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity decoder_5to32 is
  port(
       iA               : in std_logic_vector(5-1 downto 0);
       iEn              : in std_logic;
       oC               : out std_logic_vector(32-1 downto 0));

end decoder_5to32;

architecture structure of decoder_5to32 is 


signal A : std_logic_vector(6-1 downto 0);

begin


  A <= iEn & iA;

  with A select oC <=
    32x"00000001" when "100000",
    32x"00000002" when "100001",
    32x"00000004" when "100010",
    32x"00000008" when "100011",

    32x"00000010" when "100100",
    32x"00000020" when "100101",
    32x"00000040" when "100110",
    32x"00000080" when "100111",


    32x"00000100" when "101000",
    32x"00000200" when "101001",
    32x"00000400" when "101010",
    32x"00000800" when "101011",

    32x"00001000" when "101100",
    32x"00002000" when "101101",
    32x"00004000" when "101110",
    32x"00008000" when "101111",



    32x"00010000" when "110000",
    32x"00020000" when "110001",
    32x"00040000" when "110010",
    32x"00080000" when "110011",

    32x"00100000" when "110100",
    32x"00200000" when "110101",
    32x"00400000" when "110110",
    32x"00800000" when "110111",


    32x"01000000" when "111000",
    32x"02000000" when "111001",
    32x"04000000" when "111010",
    32x"08000000" when "111011",

    32x"10000000" when "111100",
    32x"20000000" when "111101",
    32x"40000000" when "111110",
    32x"80000000" when "111111",
    32x"00000000" when others;


  
end structure;
