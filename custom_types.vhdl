-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components - custom_types.vhdl
-- 4/5/17

library ieee;
use ieee.std_logic_1164.all;

package custom_types is
    type array_2d is array (natural range <>, natural range <>) of std_logic;
end custom_types;
--Because we could not get VHDL 2008 to work, we decided to use a 2D array made up
--of individual std_logics. Because of this, we have to individual access each position
--in each "vector."
