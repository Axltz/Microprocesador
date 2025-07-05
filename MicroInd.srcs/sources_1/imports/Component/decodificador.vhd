library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodificador is
    Port (
        instruccion : in  STD_LOGIC_VECTOR(11 downto 0);  
        operacion   : out STD_LOGIC_VECTOR(2 downto 0)  

    );
end decodificador;

architecture Behavioral of decodificador is
begin
    process(instruccion)
    begin
        operacion <= instruccion(11 downto 9);

    end process;
end Behavioral;
