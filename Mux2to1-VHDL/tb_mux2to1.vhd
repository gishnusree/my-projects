library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux2to1 is
-- no ports, testbench only
end tb_mux2to1;

architecture behavior of tb_mux2to1 is

    -- Component Declaration for the Unit Under Test (UUT)
    component mux2to1
        Port (
            a : in  STD_LOGIC;
            b : in  STD_LOGIC;
            sel : in  STD_LOGIC;
            y : out STD_LOGIC
        );
    end component;

    -- Signals to connect to UUT
    signal a   : STD_LOGIC := '0';
    signal b   : STD_LOGIC := '0';
    signal sel : STD_LOGIC := '0';
    signal y   : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: mux2to1 port map (
        a => a,
        b => b,
        sel => sel,
        y => y
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- test case 1
        a <= '0'; b <= '1'; sel <= '0';
        wait for 10 ns;

        -- test case 2
        a <= '0'; b <= '1'; sel <= '1';
        wait for 10 ns;

        -- test case 3
        a <= '1'; b <= '0'; sel <= '0';
        wait for 10 ns;

        -- test case 4
        a <= '1'; b <= '0'; sel <= '1';
        wait for 10 ns;

        wait;
    end process;

end behavior;
