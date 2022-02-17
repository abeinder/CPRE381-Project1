-------------------------------------------------------------------------
-- Austin Beinder
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2:1 multiplexer.
--
--
-- NOTES:
-- 1/23/22 Austin Beinder::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity mux2t1 is

    port(iA     : in std_logic;
         iB     : in std_logic;
         iSel   : in std_logic;
         oX     : out std_logic);

end mux2t1;

architecture structure of mux2t1 is

    component andg2 is

        port(i_A          : in std_logic;
             i_B          : in std_logic;
             o_F          : out std_logic);
      
    end component;
    

    component invg is

        port(i_A          : in std_logic;
             o_F          : out std_logic);
      
    end component;

    component org2 is

        port(i_A          : in std_logic;
             i_B          : in std_logic;
             o_F          : out std_logic);
      
    end component;


    -- Internal Signals
    signal s_snot   : std_logic;
    signal s_bsel   : std_logic;
    signal s_asel   : std_logic;
    
    begin 
        g_Invert: invg
            port MAP(i_A    => iSel,
                    o_F    => s_snot);
        
        g_bAnd: andg2
            port MAP(i_A    => s_snot,
                    i_B    => iB,
                    o_F    => s_bsel);

        g_aAnd: andg2
        port MAP(i_A    => iSel,
                i_B    => iA,
                o_F    => s_asel);

        g_Or: org2
            port MAP(i_A    => s_asel,
                    i_B    => s_bsel,
                    o_F    => oX);
    
    end structure;
