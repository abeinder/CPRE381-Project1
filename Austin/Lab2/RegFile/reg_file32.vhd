-------------------------------------------------------------------------
-- Austin Beinder
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux_32_32to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a 32bit 32:1 32 bit mux.
--
--


-- 02/10/22 by Austin Beinder::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity reg_file32 is
  port(
       iA               : in std_logic_vector(32-1 downto 0);
       iDest            : in std_logic_vector(5-1 downto 0);
       iwrite          : in std_logic;
       iRd0            : in std_logic_vector(5-1 downto 0);
       iRd1            : in std_logic_vector(5-1 downto 0);
       iRst             : in std_logic;
       iClk             : in std_logic;
       o0               : out std_logic_vector(32-1 downto 0);
       o1               : out std_logic_vector(32-1 downto 0)
    );

end reg_file32;

architecture structure of reg_file32 is 

component mux_32_32to1 is
    port(
         i_00             : in std_logic_vector(32-1 downto 0);
         i_01             : in std_logic_vector(32-1 downto 0);
         i_02             : in std_logic_vector(32-1 downto 0);
         i_03             : in std_logic_vector(32-1 downto 0);
         i_04             : in std_logic_vector(32-1 downto 0);
         i_05             : in std_logic_vector(32-1 downto 0);
         i_06             : in std_logic_vector(32-1 downto 0);
         i_07             : in std_logic_vector(32-1 downto 0);
         i_08             : in std_logic_vector(32-1 downto 0);
         i_09             : in std_logic_vector(32-1 downto 0);
         i_0A             : in std_logic_vector(32-1 downto 0);
         i_0B             : in std_logic_vector(32-1 downto 0);
         i_0C             : in std_logic_vector(32-1 downto 0);
         i_0D             : in std_logic_vector(32-1 downto 0);
         i_0E             : in std_logic_vector(32-1 downto 0);
         i_0F             : in std_logic_vector(32-1 downto 0);
  
         i_10             : in std_logic_vector(32-1 downto 0);
         i_11             : in std_logic_vector(32-1 downto 0);
         i_12             : in std_logic_vector(32-1 downto 0);
         i_13             : in std_logic_vector(32-1 downto 0);
         i_14             : in std_logic_vector(32-1 downto 0);
         i_15             : in std_logic_vector(32-1 downto 0);
         i_16             : in std_logic_vector(32-1 downto 0);
         i_17             : in std_logic_vector(32-1 downto 0);
         i_18             : in std_logic_vector(32-1 downto 0);
         i_19             : in std_logic_vector(32-1 downto 0);
         i_1A             : in std_logic_vector(32-1 downto 0);
         i_1B             : in std_logic_vector(32-1 downto 0);
         i_1C             : in std_logic_vector(32-1 downto 0);
         i_1D             : in std_logic_vector(32-1 downto 0);
         i_1E             : in std_logic_vector(32-1 downto 0);
         i_1F             : in std_logic_vector(32-1 downto 0);
  
         iSel             : in std_logic_vector(5-1 downto 0);
         oC               : out std_logic_vector(32-1 downto 0)
      );
  
  end component;

  component Reg is
    generic(N : integer := 32); 
    port(iCLK             : in std_logic;
         iA               : in std_logic_vector(N-1 downto 0);
         iRst             : in std_logic;
         iWe              : in std_logic;
         oC               : out std_logic_vector(N-1 downto 0));
  
  end component;
  
  component decoder_5to32 is
    port(
         iA               : in std_logic_vector(5-1 downto 0);
         iEn              : in std_logic;
         oC               : out std_logic_vector(32-1 downto 0));
  
  end component;

signal write_enable : std_logic_vector(32-1 downto 0) := 32x"00000000";
signal S00, S01, S02, S03, S04, S05, S06, S07, S08, S09, S0A, S0B, S0C, S0D, S0E, S0F : std_logic_vector(32-1 downto 0);
signal S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S1A, S1B, S1C, S1D, S1E, S1F : std_logic_vector(32-1 downto 0);

begin

    ------------------ Decoder ---------------------------
    Decoder: decoder_5to32
    port map(
      iA               => iDest,
      iEn               => iwrite,
      oC               => write_enable); -- Does this handle if I don't want to write to anywhere?

    ------------------- Registers ------------------------
        Reg00: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => 32x"00000000",
        iRst             => iRst,
        iWe              => '1',
        oC               => S00);

        Reg01: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(1),
        oC               => S01);

        Reg02: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(2),
        oC               => S02);

        Reg03: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(3),
        oC               => S03);

        Reg04: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(4),
        oC               => S04);

        Reg05: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(5),
        oC               => S05);

        Reg06: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(6),
        oC               => S06);

        Reg07: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(7),
        oC               => S07);

        Reg08: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(8),
        oC               => S08);

        Reg09: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(9),
        oC               => S09);

        Reg0A: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(10),
        oC               => S0A);

        Reg0B: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(11),
        oC               => S0B);

        Reg0C: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(12),
        oC               => S0C);

        Reg0D: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(13),
        oC               => S0D);

        Reg0E: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(14),
        oC               => S0E);

        Reg0F: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(15),
        oC               => S0F);

        Reg10: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(16),
        oC               => S10);

        Reg11: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(17),
        oC               => S11);

        Reg12: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(18),
        oC               => S12);

        Reg13: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(19),
        oC               => S13);

        Reg14: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(20),
        oC               => S14);

        Reg15: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(21),
        oC               => S15);

        Reg16: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(22),
        oC               => S16);

        Reg17: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(23),
        oC               => S17);

        Reg18: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(24),
        oC               => S18);

        Reg19: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(25),
        oC               => S19);

        Reg1A: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(26),
        oC               => S1A);

        Reg1B: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(27),
        oC               => S1B);

        Reg1C: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(28),
        oC               => S1C);

        Reg1D: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(29),
        oC               => S1D);

        Reg1E: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(30),
        oC               => S1E);

        Reg1F: Reg
        generic map (N => 32)
        port map(
        iCLK             => iClk,
        iA               => iA,
        iRst             => iRst,
        iWe              => write_enable(31),
        oC               => S1F);
    
    ------------- Mux -----------------------------
        Mux0: mux_32_32to1
        port map (
            i_00             => S00,
            i_01             => S01,
            i_02             => S02,
            i_03             => S03,
            i_04             => S04,
            i_05             => S05,
            i_06             => S06,
            i_07             => S07,
            i_08             => S08,
            i_09             => S09,
            i_0A             => S0A,
            i_0B             => S0B,
            i_0C             => S0C,
            i_0D             => S0D,
            i_0E             => S0E,
            i_0F             => S0F,

            i_10             => S10,
            i_11             => S11,
            i_12             => S12,
            i_13             => S13,
            i_14             => S14,
            i_15             => S15,
            i_16             => S16,
            i_17             => S17,
            i_18             => S18,
            i_19             => S19,
            i_1A             => S1A,
            i_1B             => S1B,
            i_1C             => S1C,
            i_1D             => S1D,
            i_1E             => S1E,
            i_1F             => S1F,

            iSel             => iRd0,
            oC               => o0);

        Mux1: mux_32_32to1
        port map (
            i_00             => S00,
            i_01             => S01,
            i_02             => S02,
            i_03             => S03,
            i_04             => S04,
            i_05             => S05,
            i_06             => S06,
            i_07             => S07,
            i_08             => S08,
            i_09             => S09,
            i_0A             => S0A,
            i_0B             => S0B,
            i_0C             => S0C,
            i_0D             => S0D,
            i_0E             => S0E,
            i_0F             => S0F,

            i_10             => S10,
            i_11             => S11,
            i_12             => S12,
            i_13             => S13,
            i_14             => S14,
            i_15             => S15,
            i_16             => S16,
            i_17             => S17,
            i_18             => S18,
            i_19             => S19,
            i_1A             => S1A,
            i_1B             => S1B,
            i_1C             => S1C,
            i_1D             => S1D,
            i_1E             => S1E,
            i_1F             => S1F,

            iSel             => iRd1,
            oC               => o1);



end structure;
