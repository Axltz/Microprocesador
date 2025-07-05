library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Microprocesador is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        set_pc      : in  STD_LOGIC;

        pc_fin      : out STD_LOGIC_VECTOR(3 downto 0);
        Ciclo       : out STD_LOGIC_VECTOR(1 downto 0);
        instr       : out STD_LOGIC_VECTOR(2 downto 0);
        mar_out     : out STD_LOGIC_VECTOR(3 downto 0);     
        Gpr_out     : out STD_LOGIC_VECTOR(11 downto 0);
        alu_result  : out STD_LOGIC_VECTOR(7 downto 0);
        buss        : out STD_LOGIC_VECTOR(11 downto 0);

        pc_out_internal         : out STD_LOGIC_VECTOR(3 downto 0);
        mar_out_internal        : out STD_LOGIC_VECTOR(3 downto 0);
        rom_out_internal        : out STD_LOGIC_VECTOR(11 downto 0);
        opc_internal            : out STD_LOGIC_VECTOR(2 downto 0);
        registro_total_internal : out STD_LOGIC_VECTOR(11 downto 0);
        alu_res_internal        : out STD_LOGIC_VECTOR(7 downto 0);
        ciclo_pulsos_internal   : out STD_LOGIC_VECTOR(1 downto 0);
        en_pc_internal          : out STD_LOGIC;
        en_mar_internal         : out STD_LOGIC;
        en_gpr_internal         : out STD_LOGIC;
        en_alu_internal         : out STD_LOGIC
    );
end Microprocesador;

architecture Behavioral of Microprocesador is

    signal pc_out         : STD_LOGIC_VECTOR(3 downto 0);
    signal mar_out2       : STD_LOGIC_VECTOR(3 downto 0);
    signal rom_out        : STD_LOGIC_VECTOR(11 downto 0);
    signal opc            : STD_LOGIC_VECTOR(2 downto 0);

    signal registro_total : STD_LOGIC_VECTOR(11 downto 0);
    signal alu_res        : STD_LOGIC_VECTOR(7 downto 0);

    signal ciclo_pulsos   : STD_LOGIC_VECTOR(1 downto 0);

    signal en_pc, en_mar, en_gpr, en_alu : STD_LOGIC;

begin
    SECUENCIADOR: entity work.ContadorB
        port map (
            CLK     => clk,
            Reset   => reset,
            Salidas => ciclo_pulsos
        );

    process(ciclo_pulsos)
    begin
        en_pc  <= '0';
        en_mar <= '0';
        en_gpr <= '0';
        en_alu <= '0';

        case ciclo_pulsos is
            when "00" => en_pc  <= '1';
            when "01" => en_mar <= '1';
            when "10" => en_gpr <= '1';
            when "11" => en_alu <= '1';
            when others => null;
        end case;
    end process;

    Ciclo <= ciclo_pulsos;

    PC: entity work.Contador
        port map (
            Enable   => en_pc,
            Reset    => reset,
            Set      => set_pc,
            Entradas => (others => '0'),
            Salidas  => pc_out
        );

    MAR: entity work.Registro8
        port map (
            enable    => en_mar, 
            Reset     => reset,
            Entradas  => pc_out,
            Salidas   => mar_out2
        );

    ROM: entity work.memoria_ROM
        port map (
            direccion => mar_out2,
            dato      => rom_out
        );

    GPR: entity work.Registro1
        port map (
            Carga        => en_gpr,
            Reset        => reset,
            Entradas     => rom_out,
            Salida_total => registro_total
        );

    Decodificador: entity work.decodificador
        port map (
            instruccion => registro_total,
            operacion   => opc
        );

    ALU: entity work.ALU_8bits
        port map (
            A   => registro_total(11 downto 8),
            B         => registro_total(7 downto 4),
            Operacion => opc,
            ENABLE    => en_alu,  
            RESET     => reset,
            RESULT    => alu_res
        );

    pc_fin     <= pc_out;  
    mar_out    <= mar_out2;    
    Gpr_out    <= registro_total;            
    instr      <= opc; 
    alu_result <= alu_res;              
    buss       <= rom_out;

    pc_out_internal         <= pc_out;
    mar_out_internal        <= mar_out2;
    rom_out_internal        <= rom_out;
    opc_internal            <= opc;
    registro_total_internal <= registro_total;
    alu_res_internal        <= alu_res;
    ciclo_pulsos_internal   <= ciclo_pulsos;
    en_pc_internal          <= en_pc;
    en_mar_internal         <= en_mar;
    en_gpr_internal         <= en_gpr;
    en_alu_internal         <= en_alu;

end Behavioral;
