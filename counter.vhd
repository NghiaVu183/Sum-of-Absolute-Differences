library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    Port ( CLK    : in  STD_LOGIC;
           RESET  : in  STD_LOGIC;
           En   : in  STD_LOGIC;
           Ld   : in  STD_LOGIC;
           D    : in INTEGER;
           Q      : out INTEGER);
end counter;

architecture Behavioral of counter is
    signal cnt : INTEGER := 0;
begin
    process(CLK, RESET)
    begin
        if RESET = '1' then
            cnt <= 0;
        elsif rising_edge(CLK) then
            if Ld = '1' then
                cnt <= D;
            elsif En = '1' then
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
    Q <= cnt;
end Behavioral;
