-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components -  shiftreg_4bit.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;

entity shiftreg_4bit is
    port(I : in std_logic_vector (3 downto 0);
    	I_SHIFT_IN : in std_logic; -- The new right most value for left shift or new left most value for right shift
    	sel : in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
    	clock : in std_logic; -- positive level triggering in problem 3
    	enable : in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
    	O : out std_logic_vector(3 downto 0)
    );
end shiftreg_4bit;

architecture behavorial of shiftreg_4bit is
signal data : std_logic_vector (3 downto 0) := "0000";
begin
    process(clock, enable)
    begin
        if enable = '0' then -- enable is asynchronous
            data <= "0000";
        elsif (clock'event and clock ='1' and enable = '1') then
            if sel = "00" then --hold
                --Do nothing, data should maintain its previous value (data <= data;)
            elsif sel = "01" then --shift left
                data(3) <= data(2);
                data(2) <= data(1);
                data(1) <= data(0);
                data(0) <= I_SHIFT_IN;
            elsif sel = "10" then --shift right
                data(3) <= I_SHIFT_IN;
                data(2) <= data(3);
                data(1) <= data(2);
                data(0) <= data(1);
            else --sel = "11" load
                data <= I;
            end if;
        end if;
    end process;
    O <= data;
end behavorial;
