-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components -  shiftreg_8bit_tb.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;

entity shiftreg_8bit_tb is
end shiftreg_8bit_tb;

architecture behav of shiftreg_8bit_tb is
component shiftreg_8bit
    port(I : in std_logic_vector (7 downto 0);
    	I_SHIFT_IN : in std_logic;
    	sel : in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
    	clock : in std_logic;
    	enable : in std_logic;
    	O : out std_logic_vector(7 downto 0)
    );
end component;

signal i, o : std_logic_vector(7 downto 0);
signal i_shift_in, clk, enable : std_logic;
signal sel : std_logic_vector(1 downto 0);

begin
shiftreg_8bit_0: shiftreg_8bit port map (i, i_shift_in, sel, clk, enable, o);

process
    type pattern_type is record
        i: std_logic_vector (7 downto 0);
        i_shift_in, clock, enable: std_logic;
        sel: std_logic_vector(1 downto 0);
        expected_o: std_logic_vector (7 downto 0);
    end record;
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
    --i_shift_in = 0, clock = 0, enable = 1, sel = XX
    (("10100011", '0', '0', '1', "11", "00000000"),
    ("01101100", '0', '0', '1', "11", "00000000"),
    ("10100011", '0', '0', '1', "10", "00000000"),
    ("01101100", '0', '0', '1', "10", "00000000"),
    ("10100011", '0', '0', '1', "01", "00000000"),
    ("01101100", '0', '0', '1', "01", "00000000"),
    ("10100011", '0', '0', '1', "00", "00000000"),
    ("01101100", '0', '0', '1', "00", "00000000"),
    --i_shift_in = 1, clock = 0, enable = 1, sel = XX
    ("10100011", '1', '0', '1', "11", "00000000"),
    ("01101100", '1', '0', '1', "11", "00000000"),
    ("10100011", '1', '0', '1', "10", "00000000"),
    ("01101100", '1', '0', '1', "10", "00000000"),
    ("10100011", '1', '0', '1', "01", "00000000"),
    ("01101100", '1', '0', '1', "01", "00000000"),
    ("10100011", '1', '0', '1', "00", "00000000"),
    ("01101100", '1', '0', '1', "00", "00000000"),
    --i_shift_in = 0, clock = 1, enable = 1, sel = XX
    ("10100011", '0', '1', '1', "11", "10100011"),--load
    ("01101100", '0', '1', '1', "11", "01101100"),--load
    ("10100011", '0', '1', '1', "10", "00110110"),--shift right
    ("01101100", '0', '1', '1', "10", "00011011"),--shift right
    ("10100011", '0', '1', '1', "01", "00110110"),--shift left
    ("01101100", '0', '1', '1', "01", "01101100"),--shift left
    ("10100011", '0', '1', '1', "00", "01101100"),--hold
    ("01101100", '0', '1', '1', "00", "01101100"),--hold
    --i_shift_in = 1, clock = 1, enable = 1, sel = XX
    ("10100011", '1', '1', '1', "11", "10100011"),--load
    ("01101100", '1', '1', '1', "11", "01101100"),--load
    ("10100011", '1', '1', '1', "10", "10110110"),--shift right
    ("01101100", '1', '1', '1', "10", "11011011"),--shift right
    ("10100011", '1', '1', '1', "01", "10110111"),--shift left
    ("01101100", '1', '1', '1', "01", "01101111"),--shift left
    ("10100011", '1', '1', '1', "00", "01101111"),--hold
    ("01101100", '1', '1', '1', "00", "01101111"),--hold
    --i_shift_in = 0, clock = 0, enable = 0, sel = XX
    ("10100011", '0', '0', '0', "11", "00000000"),
    ("01101100", '0', '0', '0', "11", "00000000"),
    ("10100011", '0', '0', '0', "10", "00000000"),
    ("01101100", '0', '0', '0', "10", "00000000"),
    ("10100011", '0', '0', '0', "01", "00000000"),
    ("01101100", '0', '0', '0', "01", "00000000"),
    ("10100011", '0', '0', '0', "00", "00000000"),
    ("01101100", '0', '0', '0', "00", "00000000"),
    --i_shift_in = 1, clock = 0, enable = 0, sel = XX
    ("10100011", '1', '0', '0', "11", "00000000"),
    ("01101100", '1', '0', '0', "11", "00000000"),
    ("10100011", '1', '0', '0', "10", "00000000"),
    ("01101100", '1', '0', '0', "10", "00000000"),
    ("10100011", '1', '0', '0', "01", "00000000"),
    ("01101100", '1', '0', '0', "01", "00000000"),
    ("10100011", '1', '0', '0', "00", "00000000"),
    ("01101100", '1', '0', '0', "00", "00000000"),
    --i_shift_in = 0, clock = 1, enable = 0, sel = XX
    ("10100011", '0', '1', '0', "11", "00000000"),--load
    ("01101100", '0', '1', '0', "11", "00000000"),--load
    ("10100011", '0', '1', '0', "10", "00000000"),--shift right
    ("01101100", '0', '1', '0', "10", "00000000"),--shift right
    ("10100011", '0', '1', '0', "01", "00000000"),--shift left
    ("01101100", '0', '1', '0', "01", "00000000"),--shift left
    ("10100011", '0', '1', '0', "00", "00000000"),--hold
    ("01101100", '0', '1', '0', "00", "00000000"),--hold
    --i_shift_in = 1, clock = 1, enable = 0, sel = XX
    ("10100011", '1', '1', '0', "11", "00000000"),--load
    ("01101100", '1', '1', '0', "11", "00000000"),--load
    ("10100011", '1', '1', '0', "10", "00000000"),--shift right
    ("01101100", '1', '1', '0', "10", "00000000"),--shift right
    ("10100011", '1', '1', '0', "01", "00000000"),--shift left
    ("01101100", '1', '1', '0', "01", "00000000"),--shift left
    ("10100011", '1', '1', '0', "00", "00000000"),--hold
    ("01101100", '1', '1', '0', "00", "00000000")--hold
    );
begin
    for n in patterns'range loop
        i <= patterns(n).i;
        i_shift_in <= patterns(n).i_shift_in;
        sel <= patterns(n).sel;
        enable <= patterns(n).enable;
        clk <= '0';
        wait for 1 ns;

        clk <= patterns(n).clock; --Create rising edge if there should be one.
        wait for 1 ns;

        assert o = patterns(n).expected_o
        report "BAD OUPUT VALUE" severity error;
        wait for 1 ns;
    end loop;
    report "END OF TEST" severity note;
    wait;
end process;
end behav;
