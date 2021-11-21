LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY mux3pra2 IS
	GENERIC ( N	: INTEGER := 16);
	PORT ( 
	
	a,b,c : in std_logic_vector(N-1 DOWNTO 0);
	sel: IN STD_LOGIC_vector(1 DOWNTO 0);
	saida : OUT std_logic_vector(N-1 DOWNTO 0));
END mux3pra2;


ARCHITECTURE comportamento OF mux3pra2 IS

BEGIN
	
	process (a,b,c,sel) is
	begin
	if (sel = "00")then
		saida <= a;
	elsif (sel = "01")then
		saida <= b;
	elsif (sel = "10")then
		saida <= c;
		
	else
		saida <= c;
	end if;
	end process;
	
	
END comportamento;