-------------------------------------------------------------------------
-- Austin Beinder
-- Iowa State University
-------------------------------------------------------------------------


-- processor_datapath2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the second MIPS datapath
--
--
-- NOTES:
-- 2/15/22 Austin Beinder::Design Created
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity processor_datapath2 is
    port(
        imm               : in std_logic_vector(16-1 downto 0); -- immediate input
        rd                : in std_logic_vector(5-1 downto 0); -- register write address
        rs                : in std_logic_vector(5-1 downto 0); -- reg read address 0
        rt                : in std_logic_vector(5-1 downto 0); -- reg read address 1

        iClk              : in std_logic;

        iRst              : in std_logic; -- clear all regs?

        idivide_by_4      : in std_logic; -- should the immediate value be divided by 4 to help offset?
        isign_unsigned    : in std_logic; -- immediate value signed or unsigned?
        imem_or_alu       : in std_logic; -- reg file input from memory or from add sub
        iwrite_mem        : in std_logic; -- write on memory
        iwrite            : in std_logic; -- write on registers
        nAdd_Sub          : in std_logic; -- add or subtract
        ALUsrc            : in std_logic; -- register or immediate

        o0                : out std_logic_vector(32-1 downto 0); -- read output 0
        o1                : out std_logic_vector(32-1 downto 0)  -- read output 1
    );
end processor_datapath2;

architecture structure of processor_datapath2 is

    component mem is
        generic (
            DATA_WIDTH : natural := 32;
            ADDR_WIDTH : natural := 10
        );
        port (
            clk		: in std_logic;
            addr	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
            data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
            we		: in std_logic := '1';
            q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
        );
    
    end component;

    component mux2t1_N is
        generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
        port(i_S          : in std_logic;
             i_D0         : in std_logic_vector(N-1 downto 0);
             i_D1         : in std_logic_vector(N-1 downto 0);
             o_O          : out std_logic_vector(N-1 downto 0));
      
    end component;

    component bit_width_extender_16to32 is
        port(
             i_A              : in std_logic_vector(16-1 downto 0);
             iSel             : in std_logic; -- if 0, 0 extend, else sign extend
             oC               : out std_logic_vector(32-1 downto 0)
          );
      
    end component;

    component divide_by_4 is
        port(
            imm               : in std_logic_vector(16-1 downto 0); -- immediate input
            divide            : in std_logic; -- should divide by 4?
            o                 : out std_logic_vector(16-1 downto 0)  
        );
    end component;

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
    signal reg_input : STD_LOGIC_VECTOR(32-1 downto 0);
    signal divide_out : STD_LOGIC_VECTOR(16-1 downto 0);
    signal mem_out : STD_LOGIC_VECTOR(32-1 downto 0);
    signal extender_out : STD_LOGIC_VECTOR(32-1 downto 0);

    begin 

        -------------------------- Path 1 ---------------------------------
        
        alu : addsub_wimm
            generic map(N => 32)
            port map (
                i_A        => o0,--
                i_B        => o1,--
                i_imm      => extender_out,--
                nAdd_Sub   => nAdd_Sub,--
                ALUsrc     => ALUsrc,--
                o_F        => addsub_out--
            );

        reg : reg_file32
            port map (
                iA               => reg_input,--
                iDest            => rd,--
                iwrite           => iwrite,--
                iRd0             => rs,--
                iRd1             => rt,--
                iRst             => iRst,--
                iClk             => iClk,--
                o0               => o0,--
                o1               => o1--
            );

        
        -----------------------------------------------------------------

        extender : bit_width_extender_16to32
            port map (
                i_A              => divide_out,
                iSel             => isign_unsigned,
                oC               => extender_out
            );

        divider : divide_by_4 
            port map (
                imm               => imm,
                divide            => idivide_by_4,
                o                 => divide_out
            );

        mem_or_alu_mux : mux2t1_N
            generic map (N => 32) -- Generic of type integer for input/output data width. Default value is 32.
            port map (
                i_S          => imem_or_alu,
                i_D0         => addsub_out,
                i_D1         => mem_out,
                o_O          => reg_input
            );
        
        memory : mem
            generic map(
                DATA_WIDTH => 32,
                ADDR_WIDTH => 10
            )
            port map(
                clk		=> iClk,
                addr	=> addsub_out(10-1 downto 0),
                data	=> o1,
                we		=> iwrite_mem,
                q		=> mem_out
            );
        
            
    
    end structure;
