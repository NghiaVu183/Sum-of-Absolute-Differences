library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package mylib is

    component computeABS is
        Port (
            in1 : in INTEGER;
            in2 : in INTEGER;
            diff : out INTEGER
        );
    end component;

    component compare is
    port(
	in1: in INTEGER;
    	in2: in INTEGER;
    	comp: out STD_LOGIC
    );
    end component;

    component counter is
        Port (
            CLK    : in STD_LOGIC;
            RESET  : in STD_LOGIC;
            En     : in STD_LOGIC;
            Ld     : in STD_LOGIC;
            D      : in INTEGER;
            Q      : out INTEGER
        );
    end component;

    component Memory is
        Port (
            clk  : in STD_LOGIC;
            WE   : in STD_LOGIC; 
            RE   : in STD_LOGIC;
            Addr : in INTEGER;
            Din  : in INTEGER;
            Dout : out INTEGER
        );
    end component;

component Controller is
    Port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        START : in STD_LOGIC;
        DONE : out STD_LOGIC;
        RE_A : out STD_LOGIC;
        RE_B : out STD_LOGIC;
        En_J : out STD_LOGIC;
        En_I : out STD_LOGIC;
        Ld_I : out STD_LOGIC;
        Ld_J : out STD_LOGIC;
        Ld_S : out STD_LOGIC;
        Zi : in STD_LOGIC;
        Zj : in STD_LOGIC
    );
end component;

component datapath is
    Port (
        CLK    : in STD_LOGIC;
        RESET  : in STD_LOGIC;
        En_i   : in STD_LOGIC;
        En_j   : in STD_LOGIC;
        WE_A   : in STD_LOGIC;
        WE_B   : in STD_LOGIC;
        RE_A   : in STD_LOGIC;
        RE_B   : in STD_LOGIC;
        Din_A  : in INTEGER;
        Din_B  : in INTEGER;
        ADDR_A : in INTEGER;
        ADDR_B : in INTEGER;
        LD_i   : in STD_LOGIC;
        LD_j   : in STD_LOGIC;
	LD_S   : in STD_LOGIC;
        En_s   : in STD_LOGIC;
	Zi, Zj : out STD_LOGIC;
        Data_out : out INTEGER
    );
end component;

component computeSAD is
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
end component;

end mylib;