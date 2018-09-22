library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_file is
	Port ( 
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
end register_file;

architecture Behavioral of register_file is

    COMPONENT reg16
	PORT(
			D : IN std_logic_vector(15 downto 0);
			load : IN std_logic;
			Clk : IN std_logic;
			Q : OUT std_logic_vector(15 downto 0)
			);
	END COMPONENT;

	COMPONENT decoder_3to8
	PORT(
			A0 : IN std_logic_vector(2 downto 0);
			Q0 : OUT std_logic;
			Q1 : OUT std_logic;
			Q2 : OUT std_logic;
			Q3 : OUT std_logic;
			Q4 : OUT std_logic;
			Q5 : OUT std_logic;
			Q6 : OUT std_logic;
			Q7 : OUT std_logic
			);
	END COMPONENT;

	COMPONENT mux8_16bit
	PORT(
			In0 : IN std_logic_vector(15 downto 0);
			In1 : IN std_logic_vector(15 downto 0);
			In2 : IN std_logic_vector(15 downto 0);
			In3 : IN std_logic_vector(15 downto 0);
			In4 : IN std_logic_vector(15 downto 0);
			In5 : IN std_logic_vector(15 downto 0);
			In6 : IN std_logic_vector(15 downto 0);
			In7 : IN std_logic_vector(15 downto 0);
			S0 : IN std_logic_vector(2 downto 0);
			Z : OUT std_logic_vector(15 downto 0)
			);
	END COMPONENT;
	
	COMPONENT mux2_16
	PORT(
	       In0 : IN std_logic_vector(15 downto 0);
	       In1 : IN std_logic_vector(15 downto 0);
	       s : IN std_logic;
	       Z : OUT std_logic_vector(15 downto 0)
       );
   END COMPONENT;
   
   COMPONENT demux_1to2
   PORT(
            In0 : IN std_logic_vector(15 downto 0);
            sel : IN std_logic;
            Z0, Z1 : OUT std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	
	signal load_reg0, load_reg1, load_reg2, load_reg3, load_reg4,
                load_reg5, load_reg6, load_reg7, load_reg8, dec_out0, dec_out1,
                dec_out2, dec_out3, dec_out4, dec_out5, dec_out6,
                dec_out7, dec_out8 : std_logic;
                
    signal reg0_q, reg1_q, reg2_q, reg3_q, reg4_q, reg5_q, reg6_q,
                            reg7_q, reg8_q, a_out, b_out, data_in_norm, data_in_other :
                            std_logic_vector(15 downto 0);
	
	begin
	
	reg0 : reg16 PORT MAP(
	   D => data_in_norm,
	   load => load_reg0,
	   Clk => Clk,
	   Q => reg0_q
	);
	
	reg1 : reg16 PORT MAP(
       D => data_in_norm,
       load => load_reg1,
       Clk => Clk,
       Q => reg1_q
    );
    
    reg2 : reg16 PORT MAP(
       D => data_in_norm,
       load => load_reg2,
       Clk => Clk,
       Q => reg2_q
    );
    
    reg3 : reg16 PORT MAP(
       D => data_in_norm,
       load => load_reg3,
       Clk => Clk,
       Q => reg3_q
    );
    
    reg4 : reg16 PORT MAP(
       D => data_in_norm,
       load => load_reg4,
       Clk => Clk,
       Q => reg4_q
    );
    
    reg5 : reg16 PORT MAP(
       D => data_in_norm,
       load => load_reg5,
       Clk => Clk,
       Q => reg5_q
    );
    
    reg6 : reg16 PORT MAP(
       D => data_in_norm,
       load => load_reg6,
       Clk => Clk,
       Q => reg6_q
    );
    
    reg7 : reg16 PORT MAP(
       D => data_in_norm,
       load => load_reg7,
       Clk => Clk,
       Q => reg7_q
    );
    
    reg8 : reg16 PORT MAP(
       D => data_in_other,
       load => load_reg8,
       Clk => Clk,
       Q => reg8_q
    );
    
    des_decoder: decoder_3to8 PORT MAP(
        A0 => dest_select(2 downto 0),
        Q0 => dec_out0,
        Q1 => dec_out1,
        Q2 => dec_out2,
        Q3 => dec_out3,
        Q4 => dec_out4,
        Q5 => dec_out5,
        Q6 => dec_out6,
        Q7 => dec_out7
    );
    
    demux: demux_1to2 PORT MAP(
        In0 => data_in,
        sel => dest_select(3),
        Z0 => data_in_norm,
        Z1 => data_in_other
    );
    
    mux8_A : mux8_16bit PORT MAP(
        In0 => reg0_q,
        In1 => reg1_q,
        In2 => reg2_q,
        In3 => reg3_q,
        In4 => reg4_q,
        In5 => reg5_q,
        In6 => reg6_q,
        In7 => reg7_q,
        S0 => select_A(2 downto 0),
        Z => a_out
    );
    
    mux8_B : mux8_16bit PORT MAP(
        In0 => reg0_q,
        In1 => reg1_q,
        In2 => reg2_q,
        In3 => reg3_q,
        In4 => reg4_q,
        In5 => reg5_q,
        In6 => reg6_q,
        In7 => reg7_q,
        S0 => select_B(2 downto 0),
        Z => b_out
    );
    
    ta_mux : mux2_16 PORT MAP(
        In0 => a_out,
        In1 => reg8_q,
        s => select_A(3),
        Z => reg_A
    );
    
    tb_mux : mux2_16 PORT MAP(
        In0 => b_out,
        In1 => reg8_q,
        s => select_B(3),
        Z => reg_B
    );
    
    
    load_reg0 <= dec_out0 and load_enable and not dest_select(3) after 1 ns;
    load_reg1 <= dec_out1 and load_enable and not dest_select(3) after 1 ns;
    load_reg2 <= dec_out2 and load_enable and not dest_select(3) after 1 ns;
    load_reg3 <= dec_out3 and load_enable and not dest_select(3) after 1 ns;
    load_reg4 <= dec_out4 and load_enable and not dest_select(3) after 1 ns;
    load_reg5 <= dec_out5 and load_enable and not dest_select(3) after 1 ns;
    load_reg6 <= dec_out6 and load_enable and not dest_select(3) after 1 ns;
    load_reg7 <= dec_out7 and load_enable and not dest_select(3) after 1 ns;
    load_reg8 <= '1';
    
    reg_0 <= reg0_q;
    reg_1 <= reg1_q;
    reg_2 <= reg2_q;
    reg_3 <= reg3_q;
    reg_4 <= reg4_q;
    reg_5 <= reg5_q;
    reg_6 <= reg6_q;
    reg_7 <= reg7_q;
    		
end Behavioral;