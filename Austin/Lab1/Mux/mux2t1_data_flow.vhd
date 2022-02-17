-------------------------------------------------------------------------
-- Austin Beinder
-- Iowa State University
-------------------------------------------------------------------------
-- mux2t1_data_flow.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2:1 multiplexer
--              utilizing a data flow behavioral description
--
--
-- NOTES:
-- 1/23/22 Austin Beinder::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity mux2t1_data_flow is

    port(iA     : in std_logic;
         iB     : in std_logic;
         iSel   : in std_logic;
         oX     : out std_logic);

end mux2t1_data_flow;
--is saying structure allowed?
architecture structure of mux2t1_data_flow is
    begin
        oX <=   iA when (iSel = '1') else
                iB;

end structure;
