-------------------------------------------------------------------------
-- Austin Beinder
-- Iowa State University
-------------------------------------------------------------------------


-- addsub_wimmm.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an addition and 
--              subtraction N bit calculator with the option to use an 
--              immediate value.
--
--
-- NOTES:
-- 2/13/22 Austin Beinder::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity addsub_wimm is
    generic(N : integer := 32);
    port(i_A      : in std_logic_vector(N-1 downto 0);
         i_B      : in std_logic_vector(N-1 downto 0);
         i_imm      : in std_logic_vector(N-1 downto 0);
         nAdd_Sub : in std_logic;
         ALUsrc   : in std_logic;
         o_F      : out std_logic_vector(N-1 downto 0));

end addsub_wimm;

architecture structure of addsub_wimm is

    component add_sub is
        generic(N : integer := 32);
        port(i_A      : in std_logic_vector(N-1 downto 0);
             i_B      : in std_logic_vector(N-1 downto 0);
             nAdd_Sub : in std_logic;
             o_F      : out std_logic_vector(N-1 downto 0));
    
    end component;

    component mux2t1_N is
        generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
        port(i_S          : in std_logic;
             i_D0         : in std_logic_vector(N-1 downto 0);
             i_D1         : in std_logic_vector(N-1 downto 0);
             o_O          : out std_logic_vector(N-1 downto 0));
      
    end component;


    -- Internal Signals
    signal mux_output : STD_LOGIC_VECTOR(N-1 downto 0);
    signal notNadd_sub : std_logic;

    begin 

        with nAdd_Sub select notNadd_sub <=
            '1' when '0',
            '0' when '1',
            '0' when others;

        mux : mux2t1_N
            generic map(N => N)
            port MAP(
                i_S => ALUsrc,
                i_D0 => i_B,
                i_D1 => i_imm,
                o_O => mux_output
            );
        
        addsub: add_sub
            generic map (N => N)
            port MAP(   i_A => i_A,
                        i_B => mux_output,
                        nAdd_Sub => notNadd_sub,
                        o_F => o_F);
            
    
    end structure;
