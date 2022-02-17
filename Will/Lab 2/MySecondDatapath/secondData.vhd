-------------------------------------------------------------------------
-- Will Galles
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- secondData.vhd
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
use IEEE.numeric_std.all;

library work;
use work.my_array.all;

entity secondData is
  port(i_CLK         : in std_logic;
        i_RS         : in std_logic_vector(4 downto 0);
        i_RT         : in std_logic_vector(4 downto 0);
        i_RD         : in std_logic_vector(4 downto 0);
        i_nAddSub    : in std_logic;
        i_ALUSrc     : in std_logic;
        i_ALU_MEM    : in std_logic;
        i_WE_M       : in std_logic;
        i_WE_R       : in std_logic;
        i_RST        : in std_logic;
        i_I          : in std_logic_vector(15 downto 0));


end secondData;

architecture structural of secondData is

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

      component mem is

        generic 
        (
            DATA_WIDTH : natural := 32;
            ADDR_WIDTH : natural := 10
        );
    
        port 
        (
            clk		: in std_logic;
            addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
            data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
            we		: in std_logic := '1';
            q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
        );
    
    end component;

    component Bit16_32 is
        port( i_A          : in std_logic_vector(15 downto 0);
              i_S          : in std_logic;
              o_O          : out  std_logic_vector(31 downto 0));
      
      end component;
    

    --Mux to ALU 
    signal s_M  : std_logic_vector(31 downto 0);
    --MUX to regFile
    signal s_R  : std_logic_vector(31 downto 0);
    --RegFile out1
    signal s_O1 : std_logic_vector(31 downto 0);
    --RegFile out2 & RegFile to Mem
    signal s_O2 : std_logic_vector(31 downto 0);
    --Carry of ALU
    signal s_C  : std_logic;
    --Ext to Mux
    signal s_Ex : std_logic_vector(31 downto 0);
    --Ext sign & RegFile Write
    signal s_Si : std_logic := '1';
    --ALU to Mux & ALU to Mem
    signal s_A : std_logic_vector(31 downto 0);
    --Mem to Mux
    signal s_Q : std_logic_vector(31 downto 0);
    --Shift
    signal s_2 : std_logic_vector(15 downto 0);
    --Shift out
    signal s_2O : std_logic_vector(15 downto 0);
    --Memory Or
    signal s_OR : std_logic;


begin

    s_2 <= i_I(15) & I_I(15) & i_I(15 downto 2);
    s_OR <= i_WE_M OR i_ALU_MEM;

    --Done
    --Shift immediate if we are
    MUX_BYTE: mux2t1_N
    generic map(16)
    port MAP(i_S    =>  s_OR,     
             i_D0   =>  i_I,      
             i_D1   =>  s_2,      
             o_O    =>  s_2O); 


    --Done
    MUX_ALU: mux2t1_N
    generic map(32)
    port MAP(i_S    =>  i_ALUSrc,     
             i_D0   =>  s_O2,      
             i_D1   =>  s_Ex,      
             o_O    =>  s_M);  

    MUX_MEM: mux2t1_N
    generic map(32)
    port MAP(i_S    =>  i_ALU_MEM,     
             i_D0   =>  s_A,      
             i_D1   =>  s_Q,      
             o_O    =>  s_R);        
             
    --Done
    EXTEND: Bit16_32
    port MAP(i_A      =>  s_2O,
             i_S      =>  s_Si,   
             o_O      =>  s_Ex);

    --Done         
    ADDSUB: AddSub_N
    generic map(32)
    port MAP(nAdd_Sub =>  i_nAddSub,
             i_X      =>  s_O1,  
             i_Y      =>  s_M,  
             o_S      =>  s_A,  
             o_C      =>  s_C);

    --Done
    dmem: mem 
    port map(clk    => i_CLK,
            addr    => s_A(9 downto 0),
            data    => s_O2,
            we      => i_WE_M,
            q       => s_Q);

    --Done
    REGISTERFILE: regFile
    port MAP(i_CLK  => i_CLK,
            i_S     => i_RD,
            i_R1    => i_RS,
            i_R2    => i_RT,
            i_WE    => i_WE_R,
            i_RST   => i_RST,
            i_D     => s_R,
            o_Q1    => s_O1,
            o_Q2    => s_O2);

    
  
end structural;
