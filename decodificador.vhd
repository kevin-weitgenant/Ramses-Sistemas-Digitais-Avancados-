library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity decodificador is
 port(
 entrada : in STD_LOGIC_VECTOR(3 downto 0);
 saida : out STD_LOGIC_VECTOR(15 downto 0)
 );
end decodificador;
 
architecture bhv of decodificador is
begin
 
process(entrada)
begin

-- elsif's gerados de forma automatizada --->https://colab.research.google.com/drive/1gVj42NNbO4gG9eiC4ign4J8sPLRm3O9x?usp=sharing


if (entrada="0000") then
saida <= "0000000000000000";
elsif (entrada="0001") then
saida <= "0000000000000010";
elsif (entrada="0010") then
saida <= "0000000000000100";
elsif (entrada="0011") then
saida <= "0000000000001000";
elsif (entrada="0100") then
saida <= "0000000000010000";
elsif (entrada="0101") then
saida <= "0000000000100000";
elsif (entrada="0110") then
saida <= "0000000001000000";
elsif (entrada="0111") then
saida <= "0000000010000000";
elsif (entrada="1000") then
saida <= "0000000100000000";
elsif (entrada="1001") then
saida <= "0000001000000000";
elsif (entrada="1010") then
saida <= "0000010000000000";
elsif (entrada="1011") then
saida <= "0000100000000000";
elsif (entrada="1100") then
saida <= "0001000000000000";
elsif (entrada="1101") then
saida <= "0010000000000000";
elsif (entrada="1110") then
saida <= "0100000000000000";
else
saida <= "1000000000000000";
end if;
 
 
 
 
end process;
 
end bhv;
