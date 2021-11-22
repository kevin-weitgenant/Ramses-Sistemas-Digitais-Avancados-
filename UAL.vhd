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
	
	SIGNAL AUX_SAIDA,result_sumsub,resultado_sub: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	signal operacao,cout : STD_LOGIC;
	 
	
	COMPONENT somador_subtrator_16bits
    GENERIC ( N	: INTEGER := 16);
	 PORT (c0   : IN STD_LOGIC;
	       a,b  : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			 s    : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          cout,ov   : OUT STD_LOGIC);
END COMPONENT;
	
	

	
	BEGIN	

	
	
	SOMADOR_SUBTRATOR: somador_subtrator_16bits PORT MAP (operacao, A, B, result_sumsub, cout_add, ov_soma);   --prof recomendou otimizar
	
	
	
	PROCESS (controle, A, B)
	BEGIN

	
	CASE controle IS
		WHEN "000" => operacao<= '0';-- A+B 
						  AUX_SAIDA<= result_sumsub;
		
		WHEN "001" => operacao <= '1'; -- A-B  
						  AUX_SAIDA<= result_sumsub;
						  
		WHEN "010" => AUX_SAIDA <= A AND B;  -- A & B        

		WHEN "011" => AUX_SAIDA <= A OR B;	-- A||B

			
		WHEN "100" => AUX_SAIDA <= NOT A;            -- not A
		WHEN "101" => AUX_SAIDA <= (NOT A) + 1;     -- neg X


		WHEN "110" => AUX_SAIDA <= '0' & A(N-1 DOWNTO 1);    -- shr A
		when others => AUX_SAIDA <= B;                -- B

		END CASE;	
	
	END PROCESS;
	
	
	D <=AUX_SAIDA;
	cout_teste <= cout; 
	ov_teste<= ov;
	END comportamento;