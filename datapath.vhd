library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity datapath is
    Port (
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
end datapath;

architecture Behavioral of datapath is

    COMPONENT register_file 
    PORT(
           load_enable : in std_logic;
           Clk : in std_logic;
           select_A : in std_logic_vector(3 downto 0);
           select_B : in std_logic_vector(3 downto 0);
           dest_select : in std_logic_vector(3 downto 0);
           data_in : in std_logic_vector(15 downto 0);
           reg_0 : out std_logic_vector(15 downto 0);
           reg_1 : out std_logic_vector(15 downto 0);
           reg_2 : out std_logic_vector(15 downto 0);
           reg_3 : out std_logic_vector(15 downto 0);
           reg_4 : out std_logic_vector(15 downto 0);
           reg_5 : out std_logic_vector(15 downto 0);
           reg_6 : out std_logic_vector(15 downto 0);
           reg_7 : out std_logic_vector(15 downto 0);
           reg_A : out std_logic_vector(15 downto 0);
           reg_B : out std_logic_vector(15 downto 0)  
    );
    END COMPONENT;
    
    COMPONENT functional_unit
    PORT(
        A, B : in std_logic_vector(15 downto 0);
        fs : in std_logic_vector (4 downto 0);
        C, V, N, Z : out std_logic;
        F : out std_logic_vector(15 downto 0)
     );
     END COMPONENT;
     
     COMPONENT mux2_16
     PORT(
         In0 : in std_logic_vector(15 downto 0);
         In1 : in std_logic_vector(15 downto 0);
         s : in std_logic;
         Z : out std_logic_vector(15 downto 0)
     );
     END COMPONENT;
     
     signal func_out, bus_a, bus_b1, bus_b2, bus_d, zero_fill,
     sig0, sig1, sig2, sig3, sig4, sig5, sig6, sig7 : std_logic_vector(15 downto 0);
     signal td_dr, ta_sa, tb_sb : std_logic_vector(3 downto 0);
     
     
begin

    func_unit : functional_unit PORT MAP(
        A => bus_a,
        B => bus_b2,
        fs => control_word(7 downto 3),
        C => C,
        V => V,
        N => N,
        Z => Z,
        F => func_out
    );
    
    reg_file : register_file PORT MAP(
        load_enable => control_word(1),
        Clk => Clk,
        select_A => ta_sa,
        select_B => tb_sb,
        dest_select => td_dr,
        data_in => bus_d,
        reg_0 => sig0,
        reg_1 => sig1,
        reg_2 => sig2,
        reg_3 => sig3,
        reg_4 => sig4,
        reg_5 => sig5,
        reg_6 => sig6,
        reg_7 => sig7,
        reg_A => bus_a,
        reg_B => bus_b1
    );
    
    mux0 : mux2_16 PORT MAP(
        In0 => func_out,
        In1 => data_in,
        s => control_word(2),
        Z => bus_d
    );
    
    mux1 : mux2_16 PORT MAP(
        In0 => bus_b1,
        In1 => zero_fill,
        s => control_word(8),
        Z => bus_b2
    );
    
    mux2 : mux2_16 PORT MAP(
        In0 => bus_a,
        In1 => pc,
        s => control_word(0),
        Z => address_out
    );
    
    data_out <= bus_b2;
    
--    zero_fill <= "0000000000000000";
    zero_fill(2 downto 0) <= constant_in;
    zero_fill(15 downto 3) <= "0000000000000";
--    zero_fill(3) <= '0';
--    zero_fill(4) <= '0';
--    zero_fill(5) <= '0';
--    zero_fill(6) <= '0';
--    zero_fill(7) <= '0';
--    zero_fill(8) <= '0';
--    zero_fill(9) <= '0';
--    zero_fill(10) <= '0';
--    zero_fill(11) <= '0';
--    zero_fill(12) <= '0';
--    zero_fill(13) <= '0';
--    zero_fill(14) <= '0';
--    zero_fill(15) <= '0'; 
    
  
    td_dr(2 downto 0) <= dest_sel;
    td_dr(3) <= control_word(11);
    
 
    ta_sa(2 downto 0) <= sel_A;
    ta_sa(3) <= control_word(10);
    
   
    tb_sb(2 downto 0) <= sel_B;
    tb_sb(3) <= control_word(9);
    
    reg0 <= sig0;
    reg1 <= sig1;
    reg2 <= sig2;
    reg3 <= sig3;
    reg4 <= sig4;
    reg5 <= sig5;
    reg6 <= sig6;
    reg7 <= sig7;      

end Behavioral;
