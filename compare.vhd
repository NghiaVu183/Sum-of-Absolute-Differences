library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity compare is
port(
    in1: in INTEGER;
    in2: in INTEGER;
    comp: out std_logic
);

end compare;

architecture behavior of compare is
    signal t_comp : std_logic;
begin 
process(in1, in2)
begin
    if in1 < in2 then
        comp <= '0';
    else
        comp <='1';
    end if;
end process;
end behavior;