library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_8bits is
    Port (
        A         : in  STD_LOGIC_VECTOR (3 downto 0); 
        B         : in  STD_LOGIC_VECTOR (3 downto 0);  
        Operacion : in  STD_LOGIC_VECTOR (2 downto 0);
        ENABLE    : in  STD_LOGIC;                      
        RESET     : in  STD_LOGIC;                      
        RESULT    : out STD_LOGIC_VECTOR (7 downto 0)   
    );
end ALU_8bits;

architecture Behavioral of ALU_8bits is
    signal resultado : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); 
begin
    process(A, B, Operacion, ENABLE, RESET)
    begin
        if RESET = '1' then
            resultado <= (others => '0');
        elsif ENABLE = '1' then
            if Operacion = "001" then  
                resultado <= "0000" & A;
            elsif Operacion = "010" then 
                resultado <= "0000" & B;
            elsif Operacion = "011" then 
                resultado <= "0000" & (A xor B);
            elsif Operacion = "100" then  
                resultado <= std_logic_vector(("0000" & unsigned(A)) + ("0000" & unsigned(B)));
            elsif Operacion = "101" then  
                resultado <= std_logic_vector(("0000" & unsigned(A)) - ("0000" & unsigned(B)));
            elsif Operacion = "110" then  
                resultado <= "0000" & (A and B);
            elsif Operacion = "111" then 
                resultado <= "0000" & (A or B);
            else
                resultado <= (others => '0');
            end if;
        else
            resultado <= (others => '0');
        end if;
    end process;

    RESULT <= resultado;
end Behavioral;

