library ieee;
use ieee.std_logic_1164.all;

entity addsub is
    port(ina, inb : in std_logic; op : out std_logic);
end entity addsub;

architecture behavioral of addsub is
begin
    op <= ina and inb;
end architecture;
