-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- ones_comp_behav.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide
-- ones complementor using behavioral implementation
--
--
-- NOTES:
-- 1/24/22 by Austin Beinder::Created File
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ones_comp_behav is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end ones_comp_behav;

architecture dataflow of ones_comp_behav is

  component invg is
        port(   i_A          : in std_logic;
                o_F          : out std_logic);

  end component;

begin

  -- Instantiate N instances.
  G_NBit_COMP: for i in 0 to N-1 generate
    o_F(i) <= not i_A(i);
  end generate G_NBit_COMP;
  
end dataflow;
