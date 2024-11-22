----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:55:43 11/19/2024 
-- Design Name: 
-- Module Name:    MasterJoystick - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MasterJoystick is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           en : in  STD_LOGIC;
           miso : in  STD_LOGIC;
           inLed1 : in  STD_LOGIC;
           inLed2 : in  STD_LOGIC;
           sclk : out  STD_LOGIC;
           ss : out  STD_LOGIC;
           mosi : out  STD_LOGIC;
           x : out  STD_LOGIC_VECTOR (9 downto 0);
           y : out  STD_LOGIC_VECTOR (9 downto 0);
           btn_joy : out  STD_LOGIC;
           btn1 : out  STD_LOGIC;
           btn2 : out  STD_LOGIC;
					 busy : out  STD_LOGIC);
end MasterJoystick;

architecture Behavioral of MasterJoystick is
	COMPONENT diviseurClk
		generic(facteur : natural);
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;          
		nclk : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT er_1octet
	PORT(
		rst : IN std_logic;
		clk : IN std_logic;
		en : IN std_logic;
		din : IN std_logic_vector(7 downto 0);
		miso : IN std_logic;          
		sclk : OUT std_logic;
		mosi : OUT std_logic;
		dout : OUT std_logic_vector(7 downto 0);
		busy : OUT std_logic
		);
	END COMPONENT;
	
	type joy_etat is (idle, init, etat_er_1octet);

	signal en_er : std_logic := '0'; -- signal en du composant er_1octet
	signal busy_er : std_logic := '0'; -- signal busy du composant er_1octet
	signal nclk : std_logic; -- clk divicé grace au composant diviseurCLK
  signal etat : joy_etat; --etat de l'automate
	signal sortie_er1octet : std_logic_vector(7 downto 0); -- sortie du composant er_1octet
	signal entre_er1octet : std_logic_vector(7 downto 0); -- entree du composant er_1octet

begin

	process(nclk, rst)
		variable num_octet : natural := 0; -- numero d'octet traité
		variable cpt_wait : natural := 15; -- compteur pour l'attente entre les transmissions

	begin
		if(rst = '0') then
		-- on met toutes les variables à leur valeur par defaut
			etat <= idle;
			en_er <= '0';
			num_octet := 0;
			x <= (others => '0');			
			y <= (others => '0');
			btn_joy <= '0';
			btn1 <= '0';
			btn2 <= '0';			
			busy <= '0';
			ss <= '1';

		elsif(rising_edge(nclk)) then
			case etat is
				when idle => 
					if (en = '1') then
						-- on met toutes les variables à leur valeur par defaut
						num_octet := 0;
						en_er <= '0';
						ss <= '0'; -- on demare la transmission avec le joystick
						busy <= '1';			
						-- on passe à l'état init
						etat <= init;
						cpt_wait := 15; -- attente avant la transmission
					end if;
					
				when init => 
					if (cpt_wait = 1) then
						if (num_octet = 0) then
							entre_er1octet <= "100000" & inLed2 & inLed1; -- au debut on envoie la valeur des leds
						else
							entre_er1octet <= (others => '0'); -- puis on envoie des 0 car pas utilise per le joystick
						end if;
						
						en_er <= '1'; -- on commence à envoyer
						etat <= etat_er_1octet; -- on passe à l'etat etat_er_1octet						
					else
						cpt_wait := cpt_wait - 1;
					end if;
					
				when etat_er_1octet => 
					en_er <= '0'; -- permet d'avoir 1 pour valeur sur un seul top d'horloge

					--si on a fini d'envoyer et de recevoir
					if ((busy_er = '0') and (en_er = '0')) then
						case num_octet is -- on met la valeur dans la bonne variable de sortie
							when 0 =>
								x(7 downto 0) <= sortie_er1octet; -- on recupere les 8 premiers bits de x
							when 1 =>
								x(9 downto 8) <= sortie_er1octet(1 downto 0); -- et les deux derniers
							when 2 =>
								y(7 downto 0) <= sortie_er1octet; -- de y
							when 3 =>
								y(9 downto 8) <= sortie_er1octet(1 downto 0);
							when 4 =>
								btn_joy <= sortie_er1octet(0); -- on recupere les bits des boutons
								btn1 <= sortie_er1octet(1);
								btn2 <= sortie_er1octet(2);
							when others =>
						end case;
						
						--on teste si on a fini
						if (num_octet = 4) then
							busy <= '0'; -- on a fini 
							ss <= '1'; -- on reset le slave
							etat <= idle; -- on repasse à l'etat idle
						else
							num_octet := num_octet +1; -- on passe à l'octet suivant
							cpt_wait := 10; --attente entre les octets
							etat <= init; -- on repart dans l'etat init
						end if;

					end if;
			end case;
		end if;
	end process;
	

	Inst_diviseurClk: diviseurClk generic map (100) PORT MAP(
		clk => clk,
		reset => rst,
		nclk => nclk
	);

	Inst_er_1octet: er_1octet PORT MAP(
		rst => rst,
		clk => nclk,
		en => en_er,
		din => entre_er1octet,
		miso => miso,
		sclk => sclk,
		mosi => mosi,
		dout => sortie_er1octet,
		busy => busy_er
	);


end Behavioral;

