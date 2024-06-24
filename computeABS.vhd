library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity computeABS is
    Port (
        in1 : in INTEGER;
        in2 : in INTEGER;
        diff : out INTEGER
    );
end computeABS;

architecture Behavioral of computeABS is
begin
    process(in1, in2)
    begin
        if(in1 > in2) then
            diff <= in1 - in2;
        else
            diff <= in2 - in1;
        end if;
    end process;
end Behavioral;