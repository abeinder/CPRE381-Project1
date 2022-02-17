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


entity mux_32_32to1 is
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

end mux_32_32to1;

architecture structure of mux_32_32to1 is 

component mux2t1_N is
    generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
    port(i_S          : in std_logic;
         i_D0         : in std_logic_vector(N-1 downto 0);
         i_D1         : in std_logic_vector(N-1 downto 0);
         o_O          : out std_logic_vector(N-1 downto 0));
  
  end component;

signal L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L1A, L1B, L1C, L1D, L1E, L1F : std_logic_vector(32-1 downto 0);
signal L20, L21, L22, L23, L24, L25, L26, L27 : std_logic_vector(32-1 downto 0);
signal L30, L31, L32, L33 : std_logic_vector(32-1 downto 0);
signal L40, L41 : std_logic_vector(32-1 downto 0);
signal L50 : std_logic_vector(32-1 downto 0);

begin

    -- ----------------- Layer 1 -----------------
    Mux10: mux2t1_N
    generic map (N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_00,
        i_D1 => i_01,
        o_O  => L10
    );

    Mux11: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_02,
        i_D1 => i_03,
        o_O  => L11
    );

    Mux12: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_04,
        i_D1 => i_05,
        o_O  => L12
    );

    Mux13: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_06,
        i_D1 => i_07,
        o_O  => L13
    );

    Mux14: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_08,
        i_D1 => i_09,
        o_O  => L14
    );

    Mux15: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_0A,
        i_D1 => i_0B,
        o_O  => L15
    );

    Mux16: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_0C,
        i_D1 => i_0D,
        o_O  => L16
    );

    Mux17: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_0E,
        i_D1 => i_0F,
        o_O  => L17
    );

    Mux18: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_10,
        i_D1 => i_11,
        o_O  => L18
    );

    Mux19: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_12,
        i_D1 => i_13,
        o_O  => L19
    );

    Mux1A: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_14,
        i_D1 => i_15,
        o_O  => L1A
    );

    Mux1B: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_16,
        i_D1 => i_17,
        o_O  => L1B
    );

    Mux1C: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_18,
        i_D1 => i_19,
        o_O  => L1C
    );

    Mux1D: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_1A,
        i_D1 => i_1B,
        o_O  => L1D
    );

    Mux1E: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_1C,
        i_D1 => i_1D,
        o_O  => L1E
    );

    Mux1F: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(0),
        i_D0 => i_1E,
        i_D1 => i_1F,
        o_O  => L1F
    );

    -------------------- Layer 2 -------------------

    Mux20: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(1),
        i_D0 => L10,
        i_D1 => L11,
        o_O  => L20
    );

    Mux21: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(1),
        i_D0 => L12,
        i_D1 => L13,
        o_O  => L21
    );

    Mux22: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(1),
        i_D0 => L14,
        i_D1 => L15,
        o_O  => L22
    );

    Mux23: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(1),
        i_D0 => L16,
        i_D1 => L17,
        o_O  => L23
    );

    Mux24: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(1),
        i_D0 => L18,
        i_D1 => L19,
        o_O  => L24
    );

    Mux25: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(1),
        i_D0 => L1A,
        i_D1 => L1B,
        o_O  => L25
    );

    Mux26: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(1),
        i_D0 => L1C,
        i_D1 => L1D,
        o_O  => L26
    );

    Mux27: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(1),
        i_D0 => L1E,
        i_D1 => L1F,
        o_O  => L27
    );

    -------------------- Layer 3 ---------------------

    Mux30: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(2),
        i_D0 => L20,
        i_D1 => L21,
        o_O  => L30
    );

    Mux31: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(2),
        i_D0 => L22,
        i_D1 => L23,
        o_O  => L31
    );

    Mux32: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(2),
        i_D0 => L24,
        i_D1 => L25,
        o_O  => L32
    );

    Mux33: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(2),
        i_D0 => L26,
        i_D1 => L27,
        o_O  => L33
    );

    ---------------------- Layer 4 ---------------------

    Mux40: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(3),
        i_D0 => L30,
        i_D1 => L31,
        o_O  => L40
    );

    Mux41: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(3),
        i_D0 => L32,
        i_D1 => L33,
        o_O  => L41
    );

    ---------------------- Layer 5 ----------------------

    Mux50: mux2t1_N
    generic map(N => 32)
    port map(
        i_S => iSel(4),
        i_D0 => L40,
        i_D1 => L41,
        o_O  => oC
    );


end structure;
