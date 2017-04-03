-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components - demux1to2y.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
use work.custom_types.all;

entity demux1to2y is
    generic(x, y : natural); --Can only be a natural numbers. x is the bit width of I/O lines. 2^y is the number of ouput lines.
    port(input : in std_logic_vector(x-1 downto 0);
        sel : in std_logic_vector(y-1 downto 0) ;
        enable : in std_logic;
        output : out array_2d(2**y - 1 downto 0, x-1 downto 0));
end entity demux1to2y;

architecture behavioral of demux1to2y is
begin
    process(sel, enable, input) is
        constant output_length : integer := 2**y - 1;
        constant data_length : integer := x - 1;
        variable sel_int : integer;
    begin
        sel_int := to_integer(unsigned(sel)); --This NEEDS to be initlized here. If you only initlize it before
        --the process begins, all tests will fail.

        if enable = '1' then --Selected output line gets input data, rest get value of 0.
            for i in 0 to output_length loop
                for j in 0 to data_length loop
                    if i = sel_int then
                        output(i, j) <= input(j);
                    else
                        output(i, j) <= '0';
                    end if;
                end loop;
            end loop;
        else -- All lines ouput should be zero
            for i in 0 to output_length loop
                for j in 0 to data_length loop
                    output(i, j) <= '0';
                end loop;
            end loop;
        end if;
    end process;
end architecture behavioral;
