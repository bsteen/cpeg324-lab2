-- Benjamin Steenkamer and Abraham McIlvaine
-- CPEG 324-010
-- Lab 2: VHDL Components - demux1to2y_tb.vhdl
-- 4/5/17
-->>>>> For this test x = 3, and y = 3 <<<<<

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
use work.custom_types.all;

entity demux1to2y_tb is
end demux1to2y_tb;

architecture behavioral of demux1to2y_tb is
component demux1to2y
    generic(x, y : natural); --Can only be a natural numbers. x is the bit width of I/O lines. 2^y is the number of ouput lines.
    port(input : in std_logic_vector(x-1 downto 0);
        sel : in std_logic_vector(y-1 downto 0);
        enable : in std_logic;
        output : out array_2d(2**y - 1 downto 0, x-1 downto 0));
end component;

signal test_input : std_logic_vector(2 downto 0):= "101";--x = 3
signal test_sel : std_logic_vector(2 downto 0) := "000";--y = 3
signal test_enable : std_logic := '1';
signal test_output : array_2d(7 downto 0, 2 downto 0);--2^3(8) ouputs, each 3 bits wide.

--Ouput signal so waveforms can be viewed in GTK Wave. Our custom array_2d can't be viewed in it.
signal out0, out1, out2, out3, out4, out5, out6, out7: std_logic_vector(2 downto 0) := "000";

begin
    demux1to2y_0: demux1to2y generic map(3,3) port map(test_input, test_sel, test_enable, test_output);
    process
        variable test_sel_int : natural;
    begin
        --Test demux when enabled
        test_enable <= '1';
        test_input <= "110";
        test_sel <= "000";

        for i in 0 to 7 loop --Loop through all 2^3 (8) output lines
            wait for 1 ns;
            if i = to_integer(unsigned(test_sel)) then --The selected line should have the input value
                assert test_output(i, 0) = test_input(0) report "BAD OUPUT VALUE, for selected line" severity error;
                assert test_output(i, 1) = test_input(1) report "BAD OUPUT VALUE, for selected line" severity error;
                assert test_output(i, 2) = test_input(2) report "BAD OUPUT VALUE, for selected line" severity error;
            else --All other non-selected lines should have all 0s.
                assert test_output(i, 0) = '0' report "BAD OUPUT VALUE, for non-selected line" severity error;
                assert test_output(i, 1) = '0' report "BAD OUPUT VALUE, for non-selected line" severity error;
                assert test_output(i, 2) = '0' report "BAD OUPUT VALUE, for non-selected line" severity error;
            end if;

            test_sel <= std_logic_vector(unsigned(test_sel) + 1); --Increment the select line.
        end loop;

        --Test demux when disbaled
        test_enable <= '0';
        test_sel <= "000";
        for i in 0 to 7 loop --Loop through outputs, since disbaled, all should hold zeros.
            wait for 1 ns;
            assert test_output(i, 0) = '0' report "BAD OUPUT VALUE, for non-selected line" severity error;
            assert test_output(i, 1) = '0' report "BAD OUPUT VALUE, for non-selected line" severity error;
            assert test_output(i, 2) = '0' report "BAD OUPUT VALUE, for non-selected line" severity error;
            test_sel <= std_logic_vector(unsigned(test_sel) + 1); --Increment the select line.
        end loop;

        report "END OF TESTS" severity note;
        wait;
    end process;

    --Used for viewing the waveform ouputs in GTK Wave.
    out0(0)<=test_output(0,0);
    out0(1)<=test_output(0,1);
    out0(2)<=test_output(0,2);
    out1(0)<=test_output(1,0);
    out1(1)<=test_output(1,1);
    out1(2)<=test_output(1,2);
    out2(0)<=test_output(2,0);
    out2(1)<=test_output(2,1);
    out2(2)<=test_output(2,2);
    out3(0)<=test_output(3,0);
    out3(1)<=test_output(3,1);
    out3(2)<=test_output(3,2);
    out4(0)<=test_output(4,0);
    out4(1)<=test_output(4,1);
    out4(2)<=test_output(4,2);
    out5(0)<=test_output(5,0);
    out5(1)<=test_output(5,1);
    out5(2)<=test_output(5,2);
    out6(0)<=test_output(6,0);
    out6(1)<=test_output(6,1);
    out6(2)<=test_output(6,2);
    out7(0)<=test_output(7,0);
    out7(1)<=test_output(7,1);
    out7(2)<=test_output(7,2);
end architecture behavioral;
