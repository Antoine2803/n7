--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:59:22 10/23/2024
-- Design Name:   
-- Module Name:   /home/ary6761/Documents/S7/Archi/xilinx/Opl/TestOpl.vhd
-- Project Name:  Opl
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MasterOpl
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TestOpl IS
END TestOpl;
 
ARCHITECTURE behavior OF TestOpl IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MasterOpl
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         en : IN  std_logic;
         v1 : IN  std_logic_vector(7 downto 0);
         v2 : IN  std_logic_vector(7 downto 0);
         miso : IN  std_logic;
         ss : OUT  std_logic;
         sclk : OUT  std_logic;
         mosi : OUT  std_logic;
         val_xor : OUT  std_logic_vector(7 downto 0);
         val_and : OUT  std_logic_vector(7 downto 0);
         val_or : OUT  std_logic_vector(7 downto 0);
         busy : OUT  std_logic
        );
    END COMPONENT;
	
				
		COMPONENT SlaveOpl
		PORT(
			sclk : IN std_logic;
			mosi : IN std_logic;
			ss : IN std_logic;          
			miso : OUT std_logic
			);
		END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal v1 : std_logic_vector(7 downto 0) := (others => '0');
   signal v2 : std_logic_vector(7 downto 0) := (others => '0');
   signal miso : std_logic := '0';

 	--Outputs
   signal ss : std_logic;
   signal sclk : std_logic;
   signal mosi : std_logic;
   signal val_xor : std_logic_vector(7 downto 0);
   signal val_and : std_logic_vector(7 downto 0);
   signal val_or : std_logic_vector(7 downto 0);
   signal busy : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
		
	 -- etats
		type t_etat is (debut, attente_active, test, fin);
		signal etat : t_etat := debut;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MasterOpl PORT MAP (
          rst => rst,
          clk => clk,
          en => en,
          v1 => v1,
          v2 => v2,
          miso => miso,
          ss => ss,
          sclk => sclk,
          mosi => mosi,
          val_xor => val_xor,
          val_and => val_and,
          val_or => val_or,
          busy => busy
        );
			
	Inst_SlaveOpl: SlaveOpl PORT MAP(
		sclk => sclk,
		mosi => mosi,
		miso => miso,
		ss => ss
	);

  -- Clock process definitions
  clk_process :process
  begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
  end process;
 
	rst <= '0', '1' after 100 ns;

  stim_proc: process(clk, rst)
    -- variables 
    variable cpt_att : natural;
    variable cpt_octet : natural;
  begin
    if(rst = '0') then
      cpt_octet := 0;
      en	 <= '0';
      v1 <= (others => 'U');
      v2 <= (others => 'U');
      etat <= debut;
    elsif(rising_edge(clk)) then

      case  etat is
        when debut =>
          -- attente de 10 cycles de l'horloge
          -- avant le premier octet
          cpt_att := 10;
          cpt_octet := 0;
          etat <= attente_active;

        when attente_active => 
					if (cpt_att = 0) then
						en <= '1';
						if (cpt_octet = 0) then
							-- premieres valeurs de test
							v1 <= "01010101";
							v2 <= "10101010";
						elsif (cpt_octet = 1) then					
							-- secondes valeurs de test
							v1 <= "11100111";
							v2 <= "11000011";
						else
							-- peut inmporte puisqu'on ne recuperera pas la valeur
					    v1 <= (others => 'U');
							v2 <= (others => 'U');		
						end if;
						etat <= test;
					end if;
					cpt_att := cpt_att -1;
				when test =>
					en <= '0';

          if(en = '0' and busy = '0') then
            -- on prépare la suite
            if(cpt_octet = 0) then
              -- il reste des octets à transmettre
              cpt_octet := cpt_octet + 1;
              -- attente de 5 cycles entre les deux transmissions
              cpt_att := 5;
							etat <= attente_active;
						elsif (cpt_octet = 1) then
							-- on recommence pour recuperer les valeurs obtenues pour les valeur precedentes
							cpt_octet := cpt_octet + 1;
              -- attente de 5 cycles entre les deux transmissions
              cpt_att := 5;
							etat <= attente_active;
            else
              -- on a fini
              etat <= fin;
            end if;
					end if;
					
        when fin => null;

      end case;

    end if;
  end process;


END;
