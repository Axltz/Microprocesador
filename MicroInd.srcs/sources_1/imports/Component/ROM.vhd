library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memoria_ROM is
    Port (
        direccion : in  STD_LOGIC_VECTOR(3 downto 0);
        dato      : out STD_LOGIC_VECTOR(11 downto 0)
    );
end memoria_ROM;

architecture Behavioral of memoria_ROM is
    type ROM_type is array (0 to 255) of STD_LOGIC_VECTOR(11 downto 0);
    signal ROM : ROM_type := (
        1 => "001000010001",  
        2 => "010000100001", 
        3 => "011000100001",  
        4 => "100000100001", 
        5 => "101000100001",
        6 => "110000100001",
        7 => "111000100001",
        others => (others => '0')
    );
begin
    dato <= ROM(to_integer(unsigned(direccion)));
end Behavioral;

