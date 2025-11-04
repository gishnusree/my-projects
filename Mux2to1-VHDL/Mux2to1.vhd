library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 2-to-1 Multiplexer
entity mux2to1 is
    Port (
        a : in  STD_LOGIC;  -- input 0
        b : in  STD_LOGIC;  -- input 1
        sel : in  STD_LOGIC; -- select line
        y : out STD_LOGIC   -- output
    );
end mux2to1;

architecture Behavioral of mux2to1 is
begin
    process(a, b, sel)
    begin
        if sel = '0' then
            y <= a;
        else
            y <= b;
        end if;
    end process;
end Behavioral;
