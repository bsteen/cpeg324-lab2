-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components - mux4to1_tb.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;

entity mux4to1_tb is
end mux4to1_tb;

architecture behavioral of mux4to1_tb is
component mux4to1 is
    generic (SIZE : natural);
    port (a, b, c, d : in std_logic_vector(SIZE-1 downto 0);
        sel : in std_logic_vector(1 downto 0);
        output : out std_logic_vector(SIZE-1 downto 0));
end component mux4to1;

signal a : std_logic_vector(7 downto 0) := "11111111";
signal b : std_logic_vector(7 downto 0) := "01101001";
signal c : std_logic_vector(7 downto 0) := "00010101";
signal d : std_logic_vector(7 downto 0) := "10000001";
signal sel : std_logic_vector(1 downto 0);
signal output : std_logic_vector(7 downto 0);
begin
    mux4to1_0: mux4to1 generic map(8) port map(a, b, c, d, sel, output);
    process
    begin
        sel <= "00";
        wait for 5 ns;
        assert output = "11111111" report "bad ouput" severity error;

        sel <= "01";
        wait for 5 ns;
        assert output = "01101001" report "bad ouput" severity error;

        sel <= "10";
        wait for 5 ns;
        assert output = "00010101" report "bad ouput" severity error;

        sel <= "11";
        wait for 5 ns;
        assert output = "10000001" report "bad ouput" severity error;
        report "TESTS COMPLETED." severity note;
        wait;
    end process;
end architecture behavioral;
