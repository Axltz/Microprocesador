library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_microprocesador is
end tb_microprocesador;

architecture Behavioral of tb_microprocesador is

    signal clk        : STD_LOGIC := '0';
    signal reset      : STD_LOGIC := '0';
    signal set_pc     : STD_LOGIC := '0';

    signal pc_fin     : STD_LOGIC_VECTOR(3 downto 0);
    signal Ciclo      : STD_LOGIC_VECTOR(1 downto 0);
    signal instr      : STD_LOGIC_VECTOR(2 downto 0);
    signal mar_out    : STD_LOGIC_VECTOR(3 downto 0);
    signal Gpr_out    : STD_LOGIC_VECTOR(11 downto 0);
    signal alu_result : STD_LOGIC_VECTOR(7 downto 0);
    signal buss       : STD_LOGIC_VECTOR(11 downto 0);

    signal pc_out_internal         : STD_LOGIC_VECTOR(3 downto 0);
    signal mar_out_internal        : STD_LOGIC_VECTOR(3 downto 0);
    signal rom_out_internal        : STD_LOGIC_VECTOR(11 downto 0);
    signal opc_internal            : STD_LOGIC_VECTOR(2 downto 0);
    signal registro_total_internal : STD_LOGIC_VECTOR(11 downto 0);
    signal alu_res_internal        : STD_LOGIC_VECTOR(7 downto 0);
    signal ciclo_pulsos_internal   : STD_LOGIC_VECTOR(1 downto 0);
    signal en_pc_internal          : STD_LOGIC;
    signal en_mar_internal         : STD_LOGIC;
    signal en_gpr_internal         : STD_LOGIC;
    signal en_alu_internal         : STD_LOGIC;

begin

    uut: entity work.Microprocesador
        port map (
            clk                     => clk,
            reset                   => reset,
            set_pc                  => set_pc,
            pc_fin                  => pc_fin,
            Ciclo                   => Ciclo,
            instr                   => instr,
            mar_out                 => mar_out,
            Gpr_out                 => Gpr_out,
            alu_result              => alu_result,
            buss                    => buss,
            pc_out_internal         => pc_out_internal,
            mar_out_internal        => mar_out_internal,
            rom_out_internal        => rom_out_internal,
            opc_internal            => opc_internal,
            registro_total_internal => registro_total_internal,
            alu_res_internal        => alu_res_internal,
            ciclo_pulsos_internal   => ciclo_pulsos_internal,
            en_pc_internal          => en_pc_internal,
            en_mar_internal         => en_mar_internal,
            en_gpr_internal         => en_gpr_internal,
            en_alu_internal         => en_alu_internal
        );
    clk_process : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    stim_proc: process
    begin
        reset <= '1';
        set_pc <= '0';
        wait for 20 ns;
        reset <= '0';
        set_pc <= '1';
        wait for 10 ns;
        set_pc <= '0';

        wait for 300 ns;
        wait;
    end process;

end Behavioral;
