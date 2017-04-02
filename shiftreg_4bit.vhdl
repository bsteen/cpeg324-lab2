-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components -  shiftreg_4bit.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;

entity shiftreg_4bit is
    port (a, b, c, d : in std_logic_vector(SIZE-1 downto 0);
        sel : in std_logic_vector(1 downto 0);
        output : out std_logic_vector(SIZE-1 downto 0));
end entity shiftreg_4bit;
