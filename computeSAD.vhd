library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.mylib.ALL;


entity computeSAD is
    port (
        CLK, RESET  : in STD_LOGIC;
        START       : in STD_LOGIC;
	Data_A : in INTEGER;
	Data_B : in INTEGER;
        WE_A, WE_B  : in STD_LOGIC;
	Addr_A_in   : in INTEGER;
        Addr_B_in   : in INTEGER;
        DONE        : out STD_LOGIC;
        Data_out    : out INTEGER
    );
end computeSAD;

architecture Behavioral of computeSAD is
    signal RE_A, RE_B : STD_LOGIC;
    signal En_I, En_J, En_s : STD_LOGIC;
    signal Ld_I, Ld_J, Ld_S : STD_LOGIC;
    signal Zi, Zj : STD_LOGIC;
    begin
    CTRL_UNIT: Controller
    port map(
        CLK, RESET,
        START, DONE,
        RE_A, RE_B,
        En_J, En_I,
        Ld_I, Ld_J,
        Ld_S,
        Zi, Zj
    );
    DATA_UNIT: Datapath
    port map(
        CLK, RESET,
        En_i, En_j,
        WE_A, WE_B,
        RE_A, RE_B,
        Data_A, Data_B,
        ADDR_A_in, ADDR_B_in,
        LD_i, LD_j,
        LD_S, En_s,
	Zi, Zj,
        Data_out
    );
end Behavioral;