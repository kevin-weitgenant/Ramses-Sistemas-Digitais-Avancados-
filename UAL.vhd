LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY UAL IS
	GENERIC ( N	: INTEGER := 16);
	PORT ( 
	controle : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
	A,B : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0 );
	cout_teste,ov_teste:OUT STD_LOGIC;  -- acrescentar ZERO
	D : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0 ));
	
	END UAL;

	
	ARCHITECTURE comportamento OF UAL IS
	SIGNAL cout_add,cout_soma,ov,ov_soma,ov_sub: STD_LOGIC;   
	
	SIGNAL AUX_SAIDA,resultado_soma,resultado_sub: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	signal add,sub,cout : STD_LOGIC;
	 
	
	COMPONENT somador_subtrator_16bits
    GENERIC ( N	: INTEGER := 16);
	 PORT (c0   : IN STD_LOGIC;
	       a,b  : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			 s    : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          cout,ov   : OUT STD_LOGIC);
END COMPONENT;
	
	

	
	BEGIN	
	add<= '0';
	sub<= '1';
	
	SOMADOR: somador_subtrator_16bits PORT MAP (add, A, B, resultado_soma, cout_add, ov_soma);
	SUBTRATOR: somador_subtrator_16bits PORT MAP (sub, A, B, resultado_sub, cout_soma, ov_sub);
	
	
	PROCESS (controle, A, B)
	BEGIN

	
	CASE controle IS
		WHEN "00" => AUX_SAIDA <= A;
		WHEN "11" => AUX_SAIDA <= A AND B;
		WHEN "01" => AUX_SAIDA <= resultado_soma;
						 cout<= cout_add;
						 ov<= ov_soma;
		WHEN "10" => AUX_SAIDA <= resultado_sub;	
		             cout<= cout_soma;
						 ov<= ov_sub;

		when others => AUX_SAIDA <= A ; 

		END CASE;	
	
	END PROCESS;
	
	
	D <=AUX_SAIDA;
	cout_teste <= cout; 
	ov_teste<= ov;
	END comportamento;