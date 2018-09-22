library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control is
    Port (
        nextAddr : in std_logic_vector(15 downto 0);
        Clk, reset, Z, C, N, V : in std_logic;
        DR, SA, SB : out std_logic_vector(2 downto 0);
        FS : out std_logic_vector(4 downto 0);
        TD, TA, TB, MB, MD, RW, MM, MW, mc_out, il_out : out std_logic;
        opcode_out, na_out : out std_logic_vector(7 downto 0);
        car_output : out std_logic_vector(7 downto 0);
        pc_out : out std_logic_vector(15 downto 0)
     );
end control;

architecture Behavioral of control is

    COMPONENT program_counter
    PORT(
        In0 : in std_logic_vector(15 downto 0);
        pi, pl, Clk, reset : in std_logic;
        Q : out std_logic_vector(15 downto 0)
    );
    END COMPONENT;
    
    COMPONENT instruction_register
    Port (
        In0 : in std_logic_vector(15 downto 0);
        IL, Clk : in std_logic;
        DR, SA, SB : out std_logic_vector(2 downto 0);
        opcode : out std_logic_vector(6 downto 0)
     );
    END COMPONENT;
    
    COMPONENT control_address_register 
    Port (
        In0 : in std_logic_vector(7 downto 0);
        sel, Clk, reset : in std_logic;
        Z : out std_logic_vector(7 downto 0)
     );
    END COMPONENT;
    
    COMPONENT control_memory
    Port ( MW : out std_logic;
        MM : out std_logic;
        RW : out std_logic;
        MD : out std_logic;
        FS : out std_logic_vector(4 downto 0);
        MB : out std_logic;
        TB : out std_logic;
        TA : out std_logic;
        TD : out std_logic;
        PL : out std_logic;
        PI : out std_logic;
        IL : out std_logic;
        MC : out std_logic;
        MS : out std_logic_vector(2 downto 0);
        NA : out std_logic_vector(7 downto 0);
        IN_CAR : in std_logic_vector(7 downto 0)
    );
    END COMPONENT;
    
    COMPONENT mux8to1
    Port ( In0, In1, In2, In3, In4, In5, In6, In7 : in std_logic;
        S0 : in std_logic_vector(2 downto 0);
        Z : out std_logic
    );
    END COMPONENT;
    
    COMPONENT mux2_8bit 
    Port (
        In0, In1 : in std_logic_vector(7 downto 0);
        s : in std_logic;
        Z : out std_logic_vector(7 downto 0) 
     );
    END COMPONENT;
    
    signal car_out, opcodeZeroed, muxS_in, muxC_out, na_sig
     : std_logic_vector(7 downto 0);
    signal pc_in, pc_q : std_logic_vector(15 downto 0);
    signal dr_sig, sa_sig, sb_sig, ms_sig : std_logic_vector(2 downto 0);
    signal pl_sig, pi_sig, il_sig, muxS_out, mc_sig : std_logic;
    signal opc_sig : std_logic_vector(6 downto 0);

begin

    pc : program_counter PORT MAP(
       In0 => pc_in,
       pi => pi_sig,
       pl => pl_sig,
       Clk => Clk,
       reset => reset,
       Q => pc_q   
    );
    
    ir : instruction_register PORT MAP(
        In0 => nextAddr,
        IL => il_sig,
        Clk => Clk,
        DR => dr_sig,
        SA => sa_sig,
        SB => sb_sig,
        opcode => opc_sig    
    );
    
    car : control_address_register PORT MAP(
        In0 => muxC_out,
        sel => muxS_out,
        Clk => Clk,
        reset => reset,
        Z => car_out
    );
    
    muxC : mux2_8bit PORT MAP(
        In0 => na_sig,
        In1 => opcodeZeroed,
        s => mc_sig,
        Z => muxC_out
    );
    
    controlMem : control_memory PORT MAP(
        IN_CAR => car_out,
        NA => na_sig,
        MS => ms_sig,
        MC => mc_sig,
        IL => il_sig,
        PI => pi_sig,
        PL => pl_sig,
        TD => TD,
        TA => TA, 
        TB => TB,
        MB => MB,
        FS => FS,
        MD => MD, 
        RW => RW,
        MM => MM,
        MW => MW
    );
    
    muxS : mux8to1 PORT MAP(
        In0 => muxS_in(0),
        In1 => muxS_in(1),
        In2 => muxS_in(2),
        In3 => muxS_in(3),
        In4 => muxS_in(4),
        In5 => muxS_in(5),
        In6 => muxS_in(6),
        In7 => muxS_in(7),
        S0 => ms_sig,
        Z => muxS_out
    );
    
    
    muxS_in(7) <= not Z;
    muxS_in(6) <= not C;
    muxS_in(5) <= N;
    muxS_in(4) <= Z;
    muxS_in(3) <= V;
    muxS_in(2) <= C;
    muxS_in(1) <= '1';
    muxS_in(0) <= '0';
    
    pc_in(15 downto 6) <= "0000000000";
    pc_in(5 downto 3) <= dr_sig;
    pc_in(2 downto 0) <= sb_sig;
    
    opcodeZeroed(7) <= '0';
    opcodeZeroed(6 downto 0) <= opc_sig;
    
    DR <= dr_sig;
    SA <= sa_sig;
    SB <= sb_sig;  
    
    pc_out <= pc_q;  
    
    car_output <= car_out;
    opcode_out <= opcodeZeroed;
    mc_out <= mc_sig;
    na_out <= na_sig;
    il_out <= il_sig;


end Behavioral;
