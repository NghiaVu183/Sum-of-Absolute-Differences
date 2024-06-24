
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controller is
    Port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        START : in STD_LOGIC := '0';
        DONE : out STD_LOGIC := '0';
        --WE_A : out STD_LOGIC;
        --WE_B : out STD_LOGIC;
        RE_A : out STD_LOGIC := '0';
        RE_B : out STD_LOGIC := '0';
        En_J : out STD_LOGIC := '0';
        En_I : out STD_LOGIC := '0';
        Ld_I : out STD_LOGIC := '1';
        Ld_J : out STD_LOGIC := '1';
        Ld_S : out STD_LOGIC := '0';
        Zi : in STD_LOGIC := '0';
        Zj : in STD_LOGIC := '0'
    );
end Controller;

architecture Behavioral of Controller is
    type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);
    signal state: state_type;
    signal next_state: state_type;
begin
    -- State register
    FSM: process(RESET,CLK)
    begin
        if RESET = '1' then
            state <= S0;
        elsif (CLK'EVENT and CLK = '1') then
            CASE State is
                when S0 =>
                    State <= S1;
                when S1 =>
                    if START = '1' then
                        State <= S2;
                    else
                        State <= S1;
                    end if;
                when S2 =>
                    state <= S3;
                when S3 =>
                    if Zi = '0' then
                        State <= S4;
                    else
                        State <= S9;
                    end if;
                when S4 =>
                    if Zj = '0' then
                        State <= S5;
                    else
                        State <= S8;
                    end if;
                when S5 =>
                    State <= S6;
                when S6 =>
                    State <= S7;
                when S7 =>
                    State <= S4;
                when S8 =>
                    State <= S3;
                when S9 =>
                    State <= S10;
                when S10 =>
                    if START = '0' then
			State <= S0;
		    else
			State <= S10;
		    end if;
                when others => State <= S0; 
            end case;
        end if;
    end process;
    -- Combinational logic
    Ld_I <= '1' when State = S2 else '0';
    Ld_J <= '1' when (State = S2 or State = S8) else '0';
    RE_A <= '1' when State = S5 else '0';
    RE_B <= '1' when State = S5 else '0';
    Ld_S <= '1' when State = S6 else '0';
    En_J <= '1' when State = S7 else '0';
    En_i <= '1' when State = S8 else '0';
    DONE <= '1' when State = S9 else '0';
    
end Behavioral;