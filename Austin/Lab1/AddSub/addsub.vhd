-------------------------------------------------------------------------
-- Austin Beinder
-- Iowa State University
-------------------------------------------------------------------------


-- addsub.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an addition and 
--              subtraction N bit calculator.
--
--
-- NOTES:
-- 1/31/22 Austin Beinder::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity add_sub is
    generic(N : integer := 32);
    port(i_A      : in std_logic_vector(N-1 downto 0);
         i_B      : in std_logic_vector(N-1 downto 0);
         nAdd_Sub : in std_logic;
         o_F      : out std_logic_vector(N-1 downto 0));

end add_sub;

architecture structure of add_sub is

    component ripple_carry_adder is

        generic(N : integer := 32);
            port(i_A     : in std_logic_vector(N-1 downto 0);
                 i_B     : in std_logic_vector(N-1 downto 0);
                 i_C     : in std_logic;
                 o_F     : out std_logic_vector(N-1 downto 0);
                 o_C     : out std_logic);
    
    end component;

    component ones_comp_struct is
        generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
        port(i_A          : in std_logic_vector(N-1 downto 0);
             o_F          : out std_logic_vector(N-1 downto 0));
      
    end component;

    component mux2t1_N is
        generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
        port(i_S          : in std_logic;
             i_D0         : in std_logic_vector(N-1 downto 0);
             i_D1         : in std_logic_vector(N-1 downto 0);
             o_O          : out std_logic_vector(N-1 downto 0));
      
    end component;


    -- Internal Signals
    signal adder_output : STD_LOGIC_VECTOR(N-1 downto 0);
    signal ones_complement : STD_LOGIC_VECTOR(N-1 downto 0);
    signal twos_complement : STD_LOGIC_VECTOR(N-1 downto 0);
    signal sub_output : STD_LOGIC_VECTOR(N-1 downto 0);
    signal one : std_logic := '1';
    signal gnd : std_logic := '0';

    signal zeros : STD_LOGIC_VECTOR(N-1 downto 0);
    
    begin 

        g_zeros: for i in 0 to N-1 generate
            zeros(i) <= gnd;
        end generate g_zeros;
        
        adder: ripple_carry_adder
            generic map (N => N)
            port MAP(   i_A => i_A,
                        i_B => i_B,
                        i_C => gnd,
                        o_F => adder_output,
                        o_C => open);
            
        ones_comp: ones_comp_struct
            generic map (N => N)
            port MAP(   i_A => i_B,
                        o_F => ones_complement);

        twos_comp_adder: ripple_carry_adder
            generic map (N => N)
            port MAP(   i_A => zeros,
                        i_B => ones_complement,
                        i_C => one,
                        o_F => twos_complement,
                        o_C => open);

        sub: ripple_carry_adder
            generic map (N => N)
            port MAP(   i_A => i_A,
                        i_B => twos_complement,
                        i_C => gnd,
                        o_F => sub_output,
                        o_C => open);

        mux: mux2t1_N
            generic map (N => N)
            port MAP(   i_S => nAdd_Sub,
                        i_D0 => sub_output,
                        i_D1 => adder_output,
                        o_O => o_F);
    
    end structure;
