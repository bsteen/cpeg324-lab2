-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components -  demux1to2y.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;

entity demux1to2y is
    generic(x, y : natural); --Can only be a natural numbers.
    port(input : in std_logic_vector(x-1 downto 0);
        sel : in std_logic_vector(y-1 downto 0);
        enable : in std_logic);
end entity demux1to2y;

architecture behavioral of demux1to2y is
begin

end architecture behavioral;
