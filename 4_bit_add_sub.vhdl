-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Componetns - gvhdl 4_bit_add_sub.vhdl
-- 4/X/17

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

-- entity full_adder is
--
-- end entity full_adder;
--
-- entity addsub_4bit is
--     port(input_a : in std_logic_vector(3 downto 0);
--          input_b : in std_logic_vector(3 downto 0);
--          sum : out std_logic_vector(3 downto 0);
--          overflow: out std_logic;
--          underflow: out std_logic);
-- end entity addsub_4bit;
--
-- architecture behavioral of addsub_4bit is
-- begin
--
-- end architecture behavioral;
