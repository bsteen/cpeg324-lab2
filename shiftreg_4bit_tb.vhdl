-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components - shiftreg_4bit_tb.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;

entity shiftreg_4bit_tb is
end shiftreg_4bit_tb;

architecture behavioral of shiftreg_4bit_tb is
component shiftreg_4bit
    port(I : in std_logic_vector (3 downto 0);
    	I_SHIFT_IN : in std_logic;
    	sel : in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
    	clock : in std_logic;
    	enable : in std_logic;
    	O : out std_logic_vector(3 downto 0)
    );
end component;

signal i, o : std_logic_vector(3 downto 0);
signal i_shift_in, clk, enable : std_logic;
signal sel : std_logic_vector(1 downto 0);

begin
shiftreg_4bit_0: shiftreg_4bit port map (i, i_shift_in, sel, clk, enable, o);

process
    type pattern_type is record
        i: std_logic_vector (3 downto 0);
        i_shift_in, clock, enable: std_logic;
        sel: std_logic_vector(1 downto 0);
        expected_o: std_logic_vector (3 downto 0);
    end record;
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
    --i_shift_in = 0, clock = 0, enable = 1, sel = XX, I = 1010 or 0110
    (("1010", '0', '0', '1', "11", "0000"),--load
    ("1010", '0', '0', '1', "10", "0000"),--shift right
    ("1010", '0', '0', '1', "01", "0000"),--shift left
    ("1010", '0', '0', '1', "00", "0000"),--hold
    ("0110", '0', '0', '1', "11", "0000"),--load
    ("0110", '0', '0', '1', "10", "0000"),--shift right
    ("0110", '0', '0', '1', "01", "0000"),--shift left
    ("0110", '0', '0', '1', "00", "0000"),--hold
    --i_shift_in = 1, clock = 0, enable = 1, sel = XX
    ("1010", '1', '0', '1', "11", "0000"),--load
    ("1010", '1', '0', '1', "10", "0000"),--shift right
    ("1010", '1', '0', '1', "01", "0000"),--shift left
    ("1010", '1', '0', '1', "00", "0000"),--hold
    ("0110", '1', '0', '1', "11", "0000"),--load
    ("0110", '1', '0', '1', "10", "0000"),--shift right
    ("0110", '1', '0', '1', "01", "0000"),--shift left
    ("0110", '1', '0', '1', "00", "0000"),--hold
    --i_shift_in = 0, clock = 1, enable = 1, sel = XX
    ("1010", '0', '1', '1', "11", "1010"),--load
    ("1010", '0', '1', '1', "10", "0101"),--shift right
    ("1010", '0', '1', '1', "01", "1010"),--shift left
    ("1010", '0', '1', '1', "00", "1010"),--hold
    ("0110", '0', '1', '1', "11", "0110"),--load
    ("0110", '0', '1', '1', "10", "0011"),--shift right
    ("0110", '0', '1', '1', "01", "0110"),--shift left
    ("0110", '0', '1', '1', "00", "0110"),--hold
    --i_shift_in = 1, clock = 1, enable = 1, sel = XX
    ("1010", '1', '1', '1', "11", "1010"),--load
    ("1010", '1', '1', '1', "10", "1101"),--shift right
    ("1010", '1', '1', '1', "01", "1011"),--shift left
    ("1010", '1', '1', '1', "00", "1011"),--hold
    ("0110", '1', '1', '1', "11", "0110"),--load
    ("0110", '1', '1', '1', "10", "1011"),--shift right
    ("0110", '1', '1', '1', "01", "0111"),--shift left
    ("0110", '1', '1', '1', "00", "0111"),--hold
    --i_shift_in = 0, clock = 0, enable = 0, sel = XX
    ("1010", '0', '0', '0', "11", "0000"),--load
    ("1010", '0', '0', '0', "10", "0000"),--shift right
    ("1010", '0', '0', '0', "01", "0000"),--shift left
    ("1010", '0', '0', '0', "00", "0000"),--hold
    ("0110", '0', '0', '0', "11", "0000"),--load
    ("0110", '0', '0', '0', "10", "0000"),--shift right
    ("0110", '0', '0', '0', "01", "0000"),--shift left
    ("0110", '0', '0', '0', "00", "0000"),--hold
    --i_shift_in = 1, clock = 0, enable = 0, sel = XX
    ("1010", '1', '0', '0', "11", "0000"),--load
    ("1010", '1', '0', '0', "10", "0000"),--shift right
    ("1010", '1', '0', '0', "01", "0000"),--shift left
    ("1010", '1', '0', '0', "00", "0000"),--hold
    ("0110", '1', '0', '0', "11", "0000"),--load
    ("0110", '1', '0', '0', "10", "0000"),--shift right
    ("0110", '1', '0', '0', "01", "0000"),--shift left
    ("0110", '1', '0', '0', "00", "0000"),--hold
    --i_shift_in = 0, clock = 1, enable = 0, sel = XX
    ("1010", '0', '1', '0', "11", "0000"),--load
    ("1010", '0', '1', '0', "10", "0000"),--shift right
    ("1010", '0', '1', '0', "01", "0000"),--shift left
    ("1010", '0', '1', '0', "00", "0000"),--hold
    ("0110", '0', '1', '0', "11", "0000"),--load
    ("0110", '0', '1', '0', "10", "0000"),--shift right
    ("0110", '0', '1', '0', "01", "0000"),--shift left
    ("0110", '0', '1', '0', "00", "0000"),--hold
    --i_shift_in = 1, clock = 1, enable = 0, sel = XX
    ("1010", '1', '1', '0', "11", "0000"),--load
    ("1010", '1', '1', '0', "10", "0000"),--shift righ
    ("1010", '1', '1', '0', "01", "0000"),--shift left
    ("1010", '1', '1', '0', "00", "0000"),--hold
    ("0110", '1', '1', '0', "11", "0000"),--load
    ("0110", '1', '1', '0', "10", "0000"),--shift right
    ("0110", '1', '1', '0', "01", "0000"),--shift left
    ("0110", '1', '1', '0', "00", "0000")--hold
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
end behavioral;
