-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- firstData.vhd
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

library work;
use work.my_array.all;

entity firstData is
  port(i_CLK         : in std_logic;
        i_RS         : in std_logic_vector(4 downto 0);
        i_RT         : in std_logic_vector(4 downto 0);
        i_RD         : in std_logic_vector(4 downto 0);
        i_nAddSub    : in std_logic;
        i_ALUSrc     : in std_logic;
        i_RST        : in std_logic;
        i_WE         : in std_logic;
        i_I          : in std_logic_vector(31 downto 0));
        --o_Q          : out std_logic_vector(31 downto 0));

end firstData;

architecture structural of firstData is

    component regFile is
        port(i_CLK         : in std_logic;
              i_S          : in std_logic_vector(4 downto 0);
              i_R1         : in std_logic_vector(4 downto 0);
              i_R2         : in std_logic_vector(4 downto 0);
              i_WE         : in std_logic;
              i_RST        : in std_logic;
              i_D          : in std_logic_vector(31 downto 0);
              o_Q1         : out std_logic_vector(31 downto 0);
              o_Q2         : out std_logic_vector(31 downto 0));
      
      end component;


      component AddSub_N is
        generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
        port(nAdd_Sub     : in std_logic;
             i_X         : in std_logic_vector(N-1 downto 0);
             i_Y         : in std_logic_vector(N-1 downto 0);
             o_S          : out std_logic_vector(N-1 downto 0);
             o_C          : out std_logic);
      
      end component;


      component mux2t1_N is
        generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
        port(i_S          : in std_logic;
             i_D0         : in std_logic_vector(N-1 downto 0);
             i_D1         : in std_logic_vector(N-1 downto 0);
             o_O          : out std_logic_vector(N-1 downto 0));
      
      end component;

    

    signal s_M  : std_logic_vector(31 downto 0);
    signal s_R  : std_logic_vector(31 downto 0);
    signal s_O1 : std_logic_vector(31 downto 0);
    signal s_O2 : std_logic_vector(31 downto 0);
    signal s_C  : std_logic;

begin

    MUX: mux2t1_N
    generic map(32)
    port MAP(i_S    =>  i_ALUSrc,     
             i_D0   =>  s_O2,      
             i_D1   =>  i_I,      
             o_O    =>  s_M);  
             
             

    ADDSUB: AddSub_N
    generic map(32)
    port MAP(nAdd_Sub =>  i_nAddSub,
             i_X      =>  s_O1,  
             i_Y      =>  s_M,  
             o_S      =>  s_R,  
             o_C      =>  s_C);
             
             

    REGISTERFILE: regFile
    port MAP(i_CLK  => i_CLK,
            i_S     => i_RD,
            i_R1    => i_RS,
            i_R2    => i_RT,
            i_WE    => i_WE,
            i_RST   => i_RST,
            i_D     => s_R,
            o_Q1    => s_O1,
            o_Q2    => s_O2);

    
  
end structural;
