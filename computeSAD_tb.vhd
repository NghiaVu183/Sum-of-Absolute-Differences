library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.mylib.ALL;

entity computeSAD_tb is
end computeSAD_tb;

architecture Behavioral of computeSAD_tb is
    signal CLK, RESET : STD_LOGIC;
    signal START : STD_LOGIC := '0';
    signal Data_A : INTEGER := 0;
    signal Data_B : INTEGER := 0;
    signal WE_A, WE_B : STD_LOGIC := '0';
    signal Addr_A_in, Addr_B_in : INTEGER := 0;
    signal DONE : STD_LOGIC := '0';
    signal Data_out : INTEGER := 0;

    -- Constants for test
    constant M: INTEGER := 3;
    constant N: INTEGER := 3;
    type matrix_type is array (0 to M-1, 0 to N-1) of INTEGER;
    signal matrix_A : matrix_type := (
        (1, 2, 3),
        (-4, -5, -6),
        (7, 8, 9)
    );
    signal matrix_B : matrix_type := (
        (10, 11, 12),
        (-13, -14, -15),
        (16, 17, 18)
    );

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: computeSAD
        port map (
            CLK => CLK,
            RESET => RESET,
            START => START,
            Data_A => Data_A,
            Data_B => Data_B,
            WE_A => WE_A,
            WE_B => WE_B,
            Addr_A_in => Addr_A_in,
            Addr_B_in => Addr_B_in,
            DONE => DONE,
            Data_out => Data_out
        );

    -- Clock generation
    CLK_sig: process
    begin
        while true loop
            CLK <= '1';
            wait for 5 ns;
            CLK <= '0';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus process
    Stimulus: process
    begin
        -- Initialize signals
        RESET <= '1';
        START <= '0';      
        wait for 20 ns;
        
        RESET <= '0';
        wait for 20 ns;

        -- Write data to memory A
        for i in 0 to M-1 loop
            for j in 0 to N-1 loop
                WE_A <= '1';
                Addr_A_in <= i * N + j;
		wait for 10 ns;
                Data_A <= matrix_A(i, j);
		WE_B <= '1';
                Addr_B_in <= i * N + j;
		wait for 10 ns;
                Data_B <= matrix_B(i, j);
                wait for 20 ns;
            end loop;
        end loop;
		
	WE_A <= '0';
	WE_B <= '0';
	wait for 20 ns;


        -- Start computation
        START <= '1';
        wait until DONE = '1';

        -- End computation
        START <= '0';

        -- End simulation
        wait;
    end process;

end Behavioral;

