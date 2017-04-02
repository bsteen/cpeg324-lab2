-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components -  mux4-1.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;
entity mux4to1 is
    generic (SIZE : natural);
    port (a, b, c, d : in std_logic_vector(SIZE-1 downto 0);
        sel : in std_logic_vector(1 downto 0);
        output : out std_logic_vector(SIZE-1 downto 0));
end entity mux4to1;

architecture behavioral of mux4to1 is
begin
    with sel select output <=
        a when "00",
        b when "01",
        c when "10",
        d when others; --i.e., when sel = "11"

end architecture behavioral;
