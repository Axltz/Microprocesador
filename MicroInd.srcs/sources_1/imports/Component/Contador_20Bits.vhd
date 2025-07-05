library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Contador is
    Port (
        Enable   : in  STD_LOGIC;                   
        Reset    : in  STD_LOGIC;
        Set      : in  STD_LOGIC;
        Entradas : in  STD_LOGIC_VECTOR(3 downto 0);
        Salidas  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Contador;

architecture Behavioral of Contador is
    signal contar : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal Enable_prev : STD_LOGIC := '0'; 
begin
    process(Enable, Reset)
    begin
        if Reset = '1' then
            contar <= (others => '0');
        else
            if (Enable_prev = '0' and Enable = '1') then
                if Set = '1' then
                    contar <= Entradas; 
                else
                    contar <= contar + 1;
                end if;
            end if;
        end if;

        Enable_prev <= Enable; 
    end process;

    Salidas <= contar;
end Behavioral;
