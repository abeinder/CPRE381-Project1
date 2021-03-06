-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- reg_N.vhd
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

entity reg_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_CLK         : in std_logic;
        i_RST        : in std_logic;
        i_WE         : in std_logic;
        i_D          : in std_logic_vector(N-1 downto 0);
        o_Q          : out std_logic_vector(N-1 downto 0));

end reg_N;

architecture structural of reg_N is

  component dffg is
    port(i_CLK       : in std_logic;     -- Clock input
        i_RST        : in std_logic;     -- Reset input
        i_WE         : in std_logic;     -- Write enable input
        i_D          : in std_logic;     -- Data value input
        o_Q          : out std_logic);   -- Data value output
  end component;

begin

  -- Instantiate N mux instances.
  G_NBit_REG: for i in 0 to N-1 generate
    REGI: dffg port map(
              i_CLK     => i_CLK,
              i_RST     => i_RST,       
              i_WE      => i_WE,  
              i_D       => i_D(i),  
              o_Q       => o_Q(i));  
  end generate G_NBit_REG;
  
end structural;
