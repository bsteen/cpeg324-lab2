-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Componetns - gvhdl 4_bit_add_sub_tb.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;

entity addsub_4bit_tb is
end addsub_4bit_tb;

architecture behavioral of addsub_4bit_tb is
component addsub_4bit is
    port(input_a, input_b : in std_logic_vector(3 downto 0);
         sum : out std_logic_vector(3 downto 0);
         overflow: out std_logic;
         underflow: out std_logic);
end component addsub_4bit;

signal a, b, s : std_logic_vector(3 downto 0);
signal o, u : std_logic;

begin   --(input_a(in), input_b(in), sum(out), overflow(out), underflow(out))
    addsub_4bit0: addsub_4bit port map(a, b, s, o, u);
    process
    type pattern_type is record
        test_a, test_b: std_logic_vector(3 downto 0); --The inputs for the 4 bit adder/subtractor
        expected_sum : std_logic_vector(3 downto 0);
        expected_overflow, expected_underflow : std_logic;
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=(
    ("0000", "0000", "0000", '0', '0'), -- 0+0 = 0
    ("0000", "0001", "0001", '0', '0'), -- 0+1 = 1
    ("0101", "0010", "0111", '0', '0'), -- 5+2 = 7
    ("0110", "0011", "1001", '1', '0'), -- 6+3 = 9, overflow
    ("0010", "1111", "0001", '0', '0'), -- 2-1 = 1
    ("1111", "1001", "1000", '0', '0'), -- -1-7 = -8
    ("1110", "0010", "0000", '0', '0'), -- -2+2 = 0
    ("1011", "1100", "0111", '0', '1') -- -5-4 = -9, underflow
    );
    begin
        for n in patterns'range loop
            a <= patterns(n).test_a;
            b <= patterns(n).test_b;
            wait for 5 ns;
            assert s = patterns(n).expected_sum report "bad sum value" severity error;
            assert o = patterns(n).expected_overflow report "bad overflow value" severity error;
            assert u = patterns(n).expected_underflow report "bad underflow value" severity error;
        end loop;
        report "Tests passed." severity note;
        wait; --  Wait forever; this will finish the simulation.
    end process;
end architecture behavioral;
