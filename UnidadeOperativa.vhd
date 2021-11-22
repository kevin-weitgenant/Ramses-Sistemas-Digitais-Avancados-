LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity UnidadeOperativa is 
	GENERIC ( N	: INTEGER := 8);
	port(
		clock, clear: in std_logic;
		loadFlags, loadMem, loadRegI, loadAcum, loadPC, loadRegEM, selMuxSaidaMem, selMuxPC, selMuxEntradaPC: in std_logic;
		selULA : in std_logic_vector (2 downto 0);
		instrucao: out std_logic_vector(N-1 downto 0);
		zero, neg: out std_logic
	);
end UnidadeOperativa;
	
architecture arqUnidadeOperativa of UnidadeOperativa is

component ula is
	GENERIC ( N	: INTEGER := 8);
	port(
		s, t: in std_logic_vector(N-1 downto 0);
		sel: in std_logic_vector(2 downto 0);
		d: out std_logic_vector(N-1 downto 0);
		cout, zero, neg: out std_logic
	);
end component;

component registrador1bits is
	--GENERIC (N : INTEGER :=8);
	port(
		 d: in std_logic;
		 load: in std_logic;
		 clock: in std_logic;
		 clear: in std_logic;
		 q: out std_logic
	);
end component;
component registradorNbits is
	--GENERIC (N : INTEGER :=8);
	port(
		 d: in std_logic_vector(8-1 downto 0);
		 load: in std_logic;
		 clock: in std_logic;
		 clear: in std_logic;
		 q: out std_logic_vector(8-1 downto 0)
	);
end component;

component mux2para1 is
	GENERIC (N : INTEGER :=8);
	port(
		 d: in std_logic_vector(N-1 downto 0);
		 d1: in std_logic_vector(N-1 downto 0);
		 sel: in std_logic;
		 q: out std_logic_vector(N-1 downto 0)
	);
end component;

component memoriaRam is
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock,clear		: IN STD_LOGIC  := '1';
		dataIn		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component;

signal saidaMem, saidaAcum, saidaMuxMem, saidaRegMem, saidaRegI, saidaUla, saidMuxPC, saidaRegPC, entradaRegPC, adressMem, saidaMuxPC, saidaRegPCMaisUm: std_logic_vector(N-1 downto 0);
signal coutTemp: std_logic;
signal negTemp, zeroTemp, saidaNeg, saidaZero : std_logic;
--signal loadFlags, loadMem, loadRegI, loadAcum, loadPC, loadRegEM: std_logic;
signal selUlaTemp: std_logic_vector(2 downto 0);
--signal selMuxSaidaMem, selMuxPC, selMuxEntradaPC: std_logic;
begin 
		
		mem: memoriaRam port map(
			address => adressMem,
			clock => clock,
			clear => clear,
			dataIn => saidaAcum,
			wren => loadMem,
			q => saidaMem
		);
		
		muxSaidaMem: mux2para1 port map(
			d => saidaMem,
			d1 => saidaAcum,
			sel => selMuxSaidaMem,
			q => saidaMuxMem
			);			
			
		ulaP: ula port map(
			s => saidaAcum,
			t => saidaMuxMem, 
			sel => selUlaTemp,
			d => saidaUla,
			cout => coutTemp,
			zero => zeroTemp,
			neg => negTemp
			);
		
		regEM: registradorNbits port map(
			d => saidaMuxPC,
			load => loadRegEM,
			clock => clock,
			clear => clear,
			q => adressMem
			);
			
		regPC: registradorNbits port map(
			d => entradaRegPC,
			load => loadPC,
			clock => clock,
			clear => clear,
			q => saidaRegPC
			);
			
		regI: registradorNbits port map(
			d => saidaMuxMem,
			load => loadRegI,
			clock => clock,
			clear => clear,
			q =>  saidaRegI
			);
		
		Acum: registradorNbits port map(
			d => saidaUla,
			load => loadAcum,
			clock => clock,
			clear => clear,
			q => saidaAcum 
			);
		
		muxPC: mux2para1 port map(
			d => saidaRegPC,
			d1 => saidaMuxMem,
			sel => selMuxPC,
			q => saidaMuxPC
			);

		muxEntradaPC: mux2para1 port map(
			d => saidaRegPCMaisUm,	--std_logic_vector(unsigned(saidaRegPC) + 1),
			d1 => saidaMuxMem,
			sel => selMuxEntradaPC,
			q => entradaRegPC
			);
		
		regNeg : registrador1bits
			--generic map (N => 1)
			port map(
			d => negTemp,
			load => loadFlags,
			clock => clock,
			clear => clear,
			q => saidaNeg
			);
		
		regZero : registrador1bits
			--generic map (N => 1)
			port map(
			d => zeroTemp,
			load => loadFlags,
			clock => clock,
			clear => clear,
			q => saidaZero
			);
		
	
		saidaRegPCMaisUm <= saidaRegPc + 1;
		selUlaTemp <= selULA;
		
		instrucao <= saidaRegI;
		neg <= saidaNeg;
		zero <= saidaZero;
end arqUnidadeOperativa;
