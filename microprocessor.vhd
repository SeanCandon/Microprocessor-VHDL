library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity microprocessor is
    Port (
        Clk, reset : in std_logic;
        pc, data_out : out std_logic_vector(15 downto 0);
        mc, il : out std_logic;
        opcode, na, car : out std_logic_vector(7 downto 0);
        reg_0 : out std_logic_vector(15 downto 0);
        reg_1 : out std_logic_vector(15 downto 0);
        reg_2 : out std_logic_vector(15 downto 0);
        reg_3 : out std_logic_vector(15 downto 0);
        reg_4 : out std_logic_vector(15 downto 0);
        reg_5 : out std_logic_vector(15 downto 0);
        reg_6 : out std_logic_vector(15 downto 0);
        reg_7 : out std_logic_vector(15 downto 0);
        control_out : out std_logic_vector(11 downto 0)
     );
end microprocessor;

architecture Behavioral of microprocessor is

    COMPONENT control
    PORT (
       nextAddr : in std_logic_vector(15 downto 0);
       Clk, reset, Z, C, N, V : in std_logic;
       DR, SA, SB : out std_logic_vector(2 downto 0);
       FS : out std_logic_vector(4 downto 0);
       TD, TA, TB, MB, MD, RW, MM, MW, mc_out, il_out : out std_logic;
       opcode_out, na_out : out std_logic_vector(7 downto 0);
       car_output : out std_logic_vector(7 downto 0);
       pc_out : out std_logic_vector(15 downto 0)
    );
    END COMPONENT;
    
    COMPONENT memory
    PORT (
        address : in std_logic_vector(15 downto 0);
        write_data : in std_logic_vector(15 downto 0);
        MemWrite : in std_logic;
        read_data : out std_logic_vector(15 downto 0)
    );
    END COMPONENT;
    
    COMPONENT datapath
    PORT (
      data_in : in std_logic_vector(15 downto 0);
      control_word : in std_logic_vector(11 downto 0);
      dest_sel : in std_logic_vector(2 downto 0);
      sel_A : in std_logic_vector(2 downto 0);
      sel_B : in std_logic_vector(2 downto 0);
      pc : in std_logic_vector(15 downto 0);
      Clk : in std_logic;
      constant_in : in std_logic_vector(2 downto 0);
      address_out, data_out : out std_logic_vector(15 downto 0);
      reg0 : out std_logic_vector(15 downto 0);
      reg1 : out std_logic_vector(15 downto 0);
      reg2 : out std_logic_vector(15 downto 0);
      reg3 : out std_logic_vector(15 downto 0);
      reg4 : out std_logic_vector(15 downto 0);
      reg5 : out std_logic_vector(15 downto 0);
      reg6 : out std_logic_vector(15 downto 0);
      reg7 : out std_logic_vector(15 downto 0);
      V, C, N, Z : out std_logic
    );
    END COMPONENT;
    
    signal control_sig : std_logic_vector(11 downto 0);
    signal mem_out, addr_sig, data_sig, pc_sig,
    sig0, sig1, sig2, sig3, sig4, sig5, sig6, sig7 : std_logic_vector(15 downto 0);
    signal v_sig, c_sig, z_sig, n_sig, td_sig, ta_sig, tb_sig,
    mb_sig, md_sig, rw_sig, mm_sig, mw_sig, mc_sig, il_sig : std_logic;
    signal dr_sig, sa_sig, sb_sig : std_logic_vector(2 downto 0);
    signal fs_sig : std_logic_vector(4 downto 0);
    signal opc_sig, na_sig, car_sig : std_logic_vector(7 downto 0);

begin

    cont : control PORT MAP(
        nextAddr => mem_out,
        Clk => Clk,
        reset => reset,
        Z => z_sig,
        C => c_sig, 
        N => n_sig,
        V => v_sig,
        DR => dr_sig,
        SA => sa_sig,
        SB => sb_sig,
        FS => fs_sig,
        TD => td_sig,
        TA => ta_sig,
        TB => tb_sig,
        MB => mb_sig,
        MD => md_sig,
        RW => rw_sig,
        MM => mm_sig,
        MW => mw_sig,
        mc_out => mc_sig,
        il_out => il_sig,
        opcode_out => opc_sig,
        na_out => na_sig,
        car_output => car_sig,
        pc_out => pc_sig
    );
    
    mem : memory PORT MAP(
       address => addr_sig,
       write_data => data_sig,
       MemWrite => mw_sig,
       read_data => mem_out 
    );
    
    dp : datapath PORT MAP(
        data_in => mem_out,
        control_word => control_sig,
        dest_sel => dr_sig,
        sel_A => sa_sig,
        sel_B => sb_sig,
        pc => pc_sig,
        Clk => Clk,
        constant_in => sb_sig,
        address_out => addr_sig,
        data_out => data_sig,
        reg0 => sig0,
        reg1 => sig1,
        reg2 => sig2,
        reg3 => sig3,
        reg4 => sig4,
        reg5 => sig5,
        reg6 => sig6,
        reg7 => sig7,
        V => v_sig,
        N => n_sig,
        C => c_sig,
        Z => z_sig
    );
    
    control_sig(11) <= td_sig;
    control_sig(10) <= ta_sig;
    control_sig(9) <= tb_sig;
    control_sig(8) <= mb_sig;
    control_sig(7 downto 3) <= fs_sig;
    control_sig(2) <= md_sig;
    control_sig(1) <= rw_sig;
    control_sig(0) <= mm_sig;
    
    pc <= pc_sig;
    data_out <= mem_out;
    mc <= mc_sig;
    il <= il_sig;
    opcode <= opc_sig;
    na <= na_sig;
    car <= car_sig;
    
    control_out <= control_sig;
    
    reg_0 <= sig0;
    reg_1 <= sig1;
    reg_2 <= sig2;
    reg_3 <= sig3;
    reg_4 <= sig4;
    reg_5 <= sig5;
    reg_6 <= sig6;
    reg_7 <= sig7;
     

end Behavioral;
