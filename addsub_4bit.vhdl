-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components - gvhdl 4_bit_add_sub.vhdl
-- 4/5/17

--Half Adder--------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity half_adder is
    port(a, b : in std_logic;
        sum, carry : out std_logic);
end entity half_adder;

architecture behavioral of half_adder is
begin
    sum <= a xor b;
    carry <= a and b;
end architecture behavioral;
--------------------------------------------------------

--Full Adder--------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity full_adder is
    port(a, b, c_in : in std_logic;
        sum, c_out : out std_logic);
end entity full_adder;

architecture structural of full_adder is
component half_adder is
    port(a, b : in std_logic;
        sum, carry : out std_logic);
end component half_adder;

signal s1, s2, s3 : std_logic;
begin                    --(a(in), b(in), sum(out), c_out(out))
    h1: half_adder port map(a, b, s1, s3);
    h2: half_adder port map(s1, c_in, sum, s2);
    c_out <= s2 or s3;
end architecture structural;
--------------------------------------------------------

--4 Bit Adder and Subtractor----------------------------
library ieee;
use ieee.std_logic_1164.all;
entity addsub_4bit is
    port(input_a, input_b : in std_logic_vector(3 downto 0);
         sum : out std_logic_vector(3 downto 0);
         overflow: out std_logic;
         underflow: out std_logic);
end entity addsub_4bit;

architecture structural of addsub_4bit is
component full_adder is
    port(a, b, c_in : in std_logic;
        sum, c_out : out std_logic);
end component full_adder;

signal c0, c1, c2, error: std_logic;
begin                     --(a(in), b(in), c_in(in), sum(out), c_out(out))
    fa0: full_adder port map(input_a(0), input_b(0),'0', sum(0), c0); --c_in for the first full_adder is always 0, i.e. nothing.
    fa1: full_adder port map(input_a(1), input_b(1), c0, sum(1), c1);
    fa2: full_adder port map(input_a(2), input_b(2), c1, sum(2), c2);
    fa3: full_adder port map(input_a(3), input_b(3), c2, sum(3), error);
    overflow <= error and (not input_a(3) and not input_b(3));--If both numbers are positive(leading 0) there could be overflow.
    underflow <= error and (input_a(3) and input_b(3));--If both numbers are negative(leading 1) there could be underflow.
end architecture structural;
--------------------------------------------------------
