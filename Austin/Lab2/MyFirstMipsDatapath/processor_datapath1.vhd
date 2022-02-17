-------------------------------------------------------------------------
-- Austin Beinder
-- Iowa State University
-------------------------------------------------------------------------


-- processor_datapath1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an addsub with a reg file datapath
--
--
-- NOTES:
-- 2/13/22 Austin Beinder::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity processor_datapath1 is
    port(
        imm               : in std_logic_vector(32-1 downto 0); -- immediate input
        rd                : in std_logic_vector(5-1 downto 0); -- write address
        iwrite            : in std_logic;
        rs                : in std_logic_vector(5-1 downto 0); -- read address 0
        rt                : in std_logic_vector(5-1 downto 0); -- read address 1
        iRst              : in std_logic;
        iClk              : in std_logic;
        nAdd_Sub          : in std_logic;
        ALUsrc            : in std_logic;
        o0                : out std_logic_vector(32-1 downto 0); -- read output 0
        o1                : out std_logic_vector(32-1 downto 0)  -- read output 1
    );

end processor_datapath1;

architecture structure of processor_datapath1 is

    component addsub_wimm is
        generic(N : integer := 32);
        port(i_A        : in std_logic_vector(N-1 downto 0);
             i_B        : in std_logic_vector(N-1 downto 0);
             i_imm      : in std_logic_vector(N-1 downto 0);
             nAdd_Sub   : in std_logic;
             ALUsrc     : in std_logic;
             o_F        : out std_logic_vector(N-1 downto 0));
    
    end component;

    component reg_file32 is
        port(
             iA               : in std_logic_vector(32-1 downto 0);
             iDest            : in std_logic_vector(5-1 downto 0);
             iwrite           : in std_logic;
             iRd0             : in std_logic_vector(5-1 downto 0);
             iRd1             : in std_logic_vector(5-1 downto 0);
             iRst             : in std_logic;
             iClk             : in std_logic;
             o0               : out std_logic_vector(32-1 downto 0);
             o1               : out std_logic_vector(32-1 downto 0)
          );
      
      end component;


    -- Internal Signals
    signal addsub_out : STD_LOGIC_VECTOR(32-1 downto 0);

    begin 
        
        alu : addsub_wimm
            generic map(N => 32)
            port map (
                i_A        => o0,
                i_B        => o1,
                i_imm      => imm,
                nAdd_Sub   => nAdd_Sub,
                ALUsrc     => ALUsrc,
                o_F        => addsub_out
            );

        reg : reg_file32
            port map (
                iA               => addsub_out,
                iDest            => rd,
                iwrite           => iwrite,
                iRd0             => rs,
                iRd1             => rt,
                iRst             => iRst,
                iClk             => iClk,
                o0               => o0,
                o1               => o1
            );
            
    
    end structure;
