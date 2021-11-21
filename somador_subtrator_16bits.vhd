LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY somador_subtrator_16bits IS
    GENERIC ( N	: INTEGER := 16);
	 PORT (c0   : IN STD_LOGIC;
	       a,b  : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			 s    : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          cout,ov   : OUT STD_LOGIC);
END somador_subtrator_16bits;

ARCHITECTURE comportamento OF somador_subtrator_16bits IS
component somador IS
    PORT (cin, a, b : IN STD_LOGIC;
          s, cout : OUT STD_LOGIC);
END component;

signal cin_temp: std_logic_vector(N DOWNTO 0);
signal aux_b: std_logic_vector(N-1 DOWNTO 0);
BEGIN

G1:  FOR i IN 0 TO N-1 GENERATE
		
		aux_b(i)<= b(i)XOR c0;
		SCs: somador PORT MAP (
			cin_temp(i), a(i), aux_b(i), s(i), cin_temp(i+1));
	  END GENERATE;

	cin_temp(0) <= c0;
	cout <= cin_temp(N);
	ov <= cin_temp(N) XOR cin_temp(N-1);

END comportamento;



	