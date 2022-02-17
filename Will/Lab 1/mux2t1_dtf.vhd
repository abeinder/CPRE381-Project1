-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1_dtf.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a basic 2-1 mux 
--              using a dataflow implementation
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity mux2t1_dtf is
    port(
        i_D0    : in std_logic;
        i_D1    : in std_logic;
        i_S     : in std_logic;
        o_O     : out std_logic);
end mux2t1_dtf;

architecture dataflow of mux2t1_dtf is
    begin
    
      o_O <= i_D1 when i_S else i_D0;
      
    end dataflow;
    