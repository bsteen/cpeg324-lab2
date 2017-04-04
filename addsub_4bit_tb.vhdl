-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Componetns - addsub_4bit_tb.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;

entity addsub_4bit_tb is
end addsub_4bit_tb;

architecture behavioral of addsub_4bit_tb is
component addsub_4bit is
    port(input_a, input_b : in std_logic_vector(3 downto 0);
        addsub_sel : in std_logic; --0 = addition, 1 is subtraction.
        sum : out std_logic_vector(3 downto 0);
        overflow: out std_logic;
        underflow: out std_logic);
end component addsub_4bit;

signal a, b, s : std_logic_vector(3 downto 0);
signal o, u, sel : std_logic;

begin   --(input_a(in), input_b(in), addsub_sel(in), sum(out), overflow(out), underflow(out))
    addsub_4bit0: addsub_4bit port map(a, b, sel, s, o, u);
    process
    type pattern_type is record
        test_a, test_b: std_logic_vector(3 downto 0); --The inputs for the 4 bit adder/subtractor
        test_sel : std_logic;
        expected_sum : std_logic_vector(3 downto 0);
        expected_overflow, expected_underflow : std_logic;
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=(
    --These tests assume you can only use the terms [-8, -7, ..., 6, 7]
    ("0000", "0000", '0', "0000", '0', '0'), -- 0+0 = 0
    ("0000", "0001", '0', "0001", '0', '0'), -- 0+1 = 1
    ("0101", "0010", '0', "0111", '0', '0'), -- 5+2 = 7
    ("0110", "0011", '0', "1001", '1', '0'), -- 6+3 = 9, overflow
    ("0010", "1111", '0', "0001", '0', '0'), -- 2+(-1) = 1
    ("0100", "1011", '0', "1111", '0', '0'), -- 4+(-5) = -1
    ("1111", "1001", '0', "1000", '0', '0'), -- -1+(-7) = -8
    ("1110", "0011", '0', "0001", '0', '0'), -- -2+3 = 1
    ("1010", "0010", '0', "1100", '0', '0'), -- -6+2 = -4
    ("1011", "1100", '0', "0111", '0', '1'), -- -5+(-4) = -9, underflow
    ("1001", "0100", '1', "0101", '0', '1'), -- -7-4 = -11, underflow
    ("0000", "0000", '1', "0000", '0', '0'), -- 0-0 = 0
    ("0010", "0001", '1', "0001", '0', '0'), -- 2-1 = 0
    ("0101", "0011", '1', "0010", '0', '0'), -- 5-3 = 2
    ("0110", "0111", '1', "1111", '0', '0'), -- 6-7 = -1
    ("0101", "1110", '1', "0111", '0', '0'), -- 5-(-2) = 7
    ("1010", "0010", '1', "1000", '0', '0'), -- -6-2 = -8
    ("1001", "1011", '1', "1110", '0', '0'), -- -7-(-5) = -2
    ("0000", "1111", '1', "0001", '0', '0'), -- 0-(-1) = -1
    ("0000", "1000", '1', "1000", '1', '0'), -- 0-(-8) = 8, overflow; You can't do (# -(-8)) since you can't represent positive 8.
                                                            --The double negative operation should become # + 8, but you can't represent positive 8 with only
                                                            --4 bits, so the actual result is (#  + (-8)) and is therefore an overflow.
    ("0010", "1000", '1', "1010", '1', '0'), -- 2-(-8) = 10, overflow (2 + -8 = -6 != 10)
    ("1100", "1000", '1', "0100", '1', '1'), -- -4-(-8) = 4, overflow, underflow. In this case, after -(-8) fails to become positve 8 (overflow),
                                                            --the operation becomes, -4 + (-8) = -12, which results in an underflow. It just happens to
                                                            --produce the correct value of 4 due to 2s complement.
    ("1101", "1011", '1', "0010", '0', '0'), -- -3-(-5) = 2
    ("0101", "1101", '1', "1000", '1', '0') -- 5-(-3) = 8, overflow
    );
    --Overall, we are saying you should not be able to enter # -(-8) without a creating an overflow error, since it is the same as trying to do # + 8, and you
    --can't enter a signed positive 8 with only 4 bits.

    begin
        for n in patterns'range loop
            a <= patterns(n).test_a;
            b <= patterns(n).test_b;
            sel <= patterns(n).test_sel;
            wait for 5 ns;
            assert s = patterns(n).expected_sum report "BAD SUM VALUE" severity error;
            assert o = patterns(n).expected_overflow report "BAD OVERFLOW VALUE" severity error;
            assert u = patterns(n).expected_underflow report "BAD UNDERFLOW VALUE" severity error;
        end loop;
        report "TESTS COMPLETED" severity note;
        wait; --  Wait forever; this will finish the simulation.
    end process;
end architecture behavioral;
