library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Memory is
    Port (
        CLK : in STD_LOGIC;
        WE : in STD_LOGIC; 
        RE : in STD_LOGIC;
        Addr : in INTEGER;
        Din : in INTEGER;
        Dout : out INTEGER
    );
end Memory;

architecture Behavioral of Memory is
    type mem_type is array (0 to 255) of INTEGER;
    signal RAM : mem_type := (others => 0);
    signal Dout_reg : INTEGER := 0;

begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if WE = '1' then
                RAM(Addr) <= Din;
            end if;
            if RE = '1' then
                Dout_reg <= RAM(Addr);
            end if;
        end if;
    end process;

    Dout <= Dout_reg;

end Behavioral;