-------------------------------------------------------------------------
-- Austin Beinder
-- Iowa State University
-------------------------------------------------------------------------


-- ripple_carry_adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a ripple carry adder
--
--
-- NOTES:
-- 1/23/22 Austin Beinder::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity ripple_carry_adder is
    generic(N : integer := 32);
    port(i_A     : in std_logic_vector(N-1 downto 0);
         i_B     : in std_logic_vector(N-1 downto 0);
         i_C     : in std_logic;
         o_F     : out std_logic_vector(N-1 downto 0);
         o_C     : out std_logic);

end ripple_carry_adder;

architecture structure of ripple_carry_adder is

    component full_adder is

        port(i_A     : in std_logic;
             i_B     : in std_logic;
             i_C     : in std_logic;
             o_F     : out std_logic;
             o_C     : out std_logic);
    
    end component;


    -- Internal Signals
    signal carries : std_logic_vector(N downto 0);
    
    begin 
        
        carries(0) <= i_C;

        G_NBIT_ADDER: for i in 0 to N-1 generate
        ADDERI: full_adder port map(
                i_A          => i_A(i),      -- All instances share the same select input.
                i_B          => i_B(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
                i_C          => carries(i),  -- ith instance's data 1 input hooked up to ith data 1 input.
                o_F          => o_F(i),
                o_C          => carries(i+1));  -- ith instance's data output hooked up to ith data output.
        end generate G_NBIT_ADDER;

        o_C <= carries(N);
    
    end structure;
