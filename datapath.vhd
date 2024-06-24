library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.mylib.ALL;

entity datapath is
    Port (
        CLK    : in STD_LOGIC;
        RESET  : in STD_LOGIC;
        En_i   : in STD_LOGIC := '0';
        En_j   : in STD_LOGIC := '0';
        WE_A   : in STD_LOGIC := '0';
        WE_B   : in STD_LOGIC := '0';
        RE_A   : in STD_LOGIC := '0';
        RE_B   : in STD_LOGIC := '0';
        Din_A  : in INTEGER := 0;
        Din_B  : in INTEGER := 0;
        ADDR_A : in INTEGER := 0;
        ADDR_B : in INTEGER := 0;
        LD_i   : in STD_LOGIC := '0';
        LD_j   : in STD_LOGIC := '0';
        LD_S   : in STD_LOGIC := '0';
        En_s   : in STD_LOGIC := '0';
        Zi, Zj : out STD_LOGIC := '0';
        Data_out : out INTEGER := 0
    );
end datapath;

architecture Behavioral of datapath is
    constant M : INTEGER := 3;
    constant N : INTEGER := 3;
    signal Dout_A, Dout_B : INTEGER;
    signal diff_ABS : INTEGER := 0;
    signal Q_i, Q_j, Q_s : INTEGER := 0;
    signal Din_S : INTEGER;
    signal Addr_A_effective, Addr_B_effective : INTEGER := 0;

begin
    memA: Memory
        port map (
            clk => CLK,
            WE => WE_A,
            RE => RE_A,
            Addr => Addr_A_effective,
            Din => Din_A,
            Dout => Dout_A
        );

    memB: Memory
        port map (
            clk => CLK,
            WE => WE_B,
            RE => RE_B,
            Addr => Addr_B_effective,
            Din => Din_B,
            Dout => Dout_B
        );

    comABS: computeABS
        port map (
            in1 => Dout_A,
            in2 => Dout_B,
            diff => diff_ABS
        );

    cnt_i: counter
        port map (
            CLK => CLK,
            RESET => RESET,
            En => En_i,
            Ld => LD_i,
            D => 0,  -- Assuming loading zero
            Q => Q_i
        );

    cnt_j: counter
        port map (
            CLK => CLK,
            RESET => RESET,
            En => En_j,
            Ld => LD_j,
            D => 0,  -- Assuming loading zero
            Q => Q_j
        );

    compare_i: compare
        port map (
            in1 => Q_i,
            in2 => M,
            comp => Zi
        );
    
    compare_j: compare
        port map (
            in1 => Q_j,
            in2 => N,
            comp => Zj
        );

    SAD: counter
        port map(
            CLK => CLK,
            RESET => RESET,
            En => En_s,
            Ld => LD_S,
            D => Din_S,
            Q => Q_s
        );

    -- Conditional address assignment
    Addr_A_effective <= Q_i*N + Q_j when RE_A = '1' else ADDR_A;
    Addr_B_effective <= Q_i*N + Q_j when RE_B = '1' else ADDR_B;

    Data_out <= Q_s;
    Din_S <= Q_s + diff_ABS;

end Behavioral;

