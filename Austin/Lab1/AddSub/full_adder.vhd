-------------------------------------------------------------------------
-- Austin Beinder
-- Iowa State University
-------------------------------------------------------------------------


-- full_adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a full adder
--
--
-- NOTES:
-- 1/23/22 Austin Beinder::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity full_adder is

    port(i_A     : in std_logic;
         i_B     : in std_logic;
         i_C     : in std_logic;
         o_F     : out std_logic;
         o_C     : out std_logic);

end full_adder;

architecture structure of full_adder is

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
    signal a11, a12, a13, a14, a15, a16, a17, a21, a22, a23, a24, a25, a26, a27 : std_logic;
    signal o1, o2, o3, o4 : std_logic;
    signal Anot, Bnot, Cnot : std_logic;
    
    begin 
        
        -- Layer 1 ------------------------------------------
        g_inv1: invg
            port MAP(i_A    => i_A,
                     o_F    => Anot);
        
        g_inv2: invg
            port MAP(i_A    => i_B,
                     o_F    => Bnot);

        g_inv3: invg
            port MAP(i_A    => i_C,
                     o_F    => Cnot);

        -- Layer 2 ------------------------------------------
        g_and11: andg2
            port MAP(i_A    => Cnot,
                     i_B    => Anot,
                     o_F    => a11);

        g_and12: andg2
            port MAP(i_A    => Cnot,
                     i_B    => i_A,
                     o_F    => a12);

        g_and13: andg2
            port MAP(i_A    => i_C,
                     i_B    => Anot,
                     o_F    => a13);

        g_and14: andg2
            port MAP(i_A    => i_C,
                     i_B    => i_A,
                     o_F    => a14);

        g_and15: andg2
            port MAP(i_A    => i_A,
                     i_B    => i_B,
                     o_F    => a15);

        g_and16: andg2
            port MAP(i_A    => i_C,
                     i_B    => Anot,
                     o_F    => a16);

        g_and17: andg2
            port MAP(i_A    => i_C,
                     i_B    => i_A,
                     o_F    => a17);
        
        -- Layer 3 ------------------------------------------
        g_and21: andg2
            port MAP(i_A    => a11,
                     i_B    => i_B,
                     o_F    => a21);

        g_and22: andg2
            port MAP(i_A    => a12,
                     i_B    => Bnot,
                     o_F    => a22);

        g_and23: andg2
            port MAP(i_A    => a13,
                     i_B    => Bnot,
                     o_F    => a23);

        g_and24: andg2
            port MAP(i_A    => a14,
                     i_B    => i_B,
                     o_F    => a24);

        g_and25: andg2
            port MAP(i_A    => a15,
                     i_B    => Cnot,
                     o_F    => a25);

        g_and26: andg2
            port MAP(i_A    => a16,
                     i_B    => i_B,
                     o_F    => a26);

        g_and27: andg2
            port MAP(i_A    => a17,
                     i_B    => Bnot,
                     o_F    => a27);

        -- Layer 4 ------------------------------------------
        g_or11: org2
            port MAP(i_A    => a21,
                     i_B    => a22,
                     o_F    => o1);

        g_or12: org2
            port MAP(i_A    => a23,
                     i_B    => a24,
                     o_F    => o2);

        g_or13: org2
            port MAP(i_A    => a24,
                     i_B    => a25,
                     o_F    => o3);

        g_or14: org2
            port MAP(i_A    => a26,
                     i_B    => a27,
                     o_F    => o4);

        -- Layer 5 ------------------------------------------

        g_or21: org2
            port MAP(i_A    => o1,
                     i_B    => o2,
                     o_F    => o_F);

        g_or22: org2
            port MAP(i_A    => o3,
                     i_B    => o4,
                     o_F    => o_C);
    
    end structure;
