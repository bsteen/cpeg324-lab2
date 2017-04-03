-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components -  shiftreg_8bit.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;

entity shiftreg_8bit is
    port(I : in std_logic_vector (7 downto 0);
    	I_SHIFT_IN : in std_logic; -- The new right most value for left shift or new left most value for right shift
    	sel : in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
    	clock : in std_logic; -- positive level triggering in problem 3
    	enable : in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
    	O : out std_logic_vector(7 downto 0)
    );
end shiftreg_8bit;

architecture structural of shiftreg_8bit is
component shiftreg_4bit is
    port(I : in std_logic_vector (3 downto 0);
    	I_SHIFT_IN : in std_logic; -- The new right most value for left shift or new left most value for right shift
    	sel : in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
    	clock : in std_logic; -- positive level triggering in problem 3
    	enable : in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
    	O : out std_logic_vector(3 downto 0)
    );
end component;
signal shift0_carry, shift1_carry : std_logic;
signal data : std_logic_vector(7 downto 0) := "00000000";
begin
    shiftreg_4bit_0: shiftreg_4bit port map(I(3 downto 0), shift0_carry, sel, clock, enable, data(3 downto 0));
    shiftreg_4bit_1: shiftreg_4bit port map(I(7 downto 4), shift1_carry, sel, clock, enable, data(7 downto 4));

    with sel select shift0_carry <=
        I_SHIFT_IN when "01", --When left shifting, the lower shifter should get the shift in.
        data(4) when "10", --carry in the right(lsb) most value of upper shifter when right shifting.
        '0' when others; --Doesn't matter what the shift in value is when not shifting left or right.

    with sel select shift1_carry <=
        data(3) when "01", --carry in the left(msb) most value of lower shifter when right shifting.
        I_SHIFT_IN when "10", --When right shifting, the upper shifter should get the shift in.
        '0' when others; --Doesn't matter what the shift in value is when not shifting left or right.

    O <= data;

end structural;
