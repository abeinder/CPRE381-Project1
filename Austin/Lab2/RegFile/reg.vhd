-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- reg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an N bit regiter.
--
--


-- 02/03/22 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Reg is
  generic(N : integer := 32); 
  port(iCLK             : in std_logic;
       iA               : in std_logic_vector(N-1 downto 0);
       iRst             : in std_logic;
       iWe              : in std_logic;
       oC               : out std_logic_vector(N-1 downto 0));

end Reg;

architecture structure of Reg is

  component dffg is
    port (
      i_CLK        : in std_logic;     -- Clock input
      i_RST        : in std_logic;     -- Reset input
      i_WE         : in std_logic;     -- Write enable input
      i_D          : in std_logic;     -- Data value input
      o_Q          : out std_logic);   -- Data value output
  end component;
  

begin
  G_NBit_Reg: for i in 0 to N-1 generate
  REGI: dffg port map(
            i_CLK      => iCLK,      
            i_D        => iA(i),  
            i_RST      => iRst, 
            i_WE       => iWe, 
            o_Q        => oC(i));  
  end generate G_NBit_Reg;

  
end structure;
