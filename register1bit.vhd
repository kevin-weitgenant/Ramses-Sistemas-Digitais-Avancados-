LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY register1bit IS 

PORT(
    
	 d   : IN STD_LOGIC;
    ld  : IN STD_LOGIC; -- load/enable.
    clr : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    q   : OUT STD_LOGIC
);
END register1bit;

ARCHITECTURE description OF register1bit IS

BEGIN
    process(clk, clr)
    begin
        if clr = '1' then
            q <= '0';
        elsif rising_edge(clk) then
            if ld = '1' then
                q <= d;
            end if;
        end if;
    end process;
END description;