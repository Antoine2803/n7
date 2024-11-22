library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MasterOpl is
  port ( rst : in std_logic;
         clk : in std_logic;
         en : in std_logic;
         v1 : in std_logic_vector (7 downto 0);
         v2 : in std_logic_vector(7 downto 0);
         miso : in std_logic;
         ss   : out std_logic;
         sclk : out std_logic;
         mosi : out std_logic;
         val_xor : out std_logic_vector (7 downto 0);
         val_and : out std_logic_vector (7 downto 0);
         val_or : out std_logic_vector (7 downto 0);
         busy : out std_logic);
end MasterOpl;

architecture behavior of MasterOpl is
	type opl_etat is (idle, waiting, etat_er_1octet);

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
	
	signal en_er : std_logic := '0';
	signal busy_er : std_logic := '0';
  signal etat : opl_etat;
	signal sortie_er1octet : std_logic_vector(7 downto 0);
	signal entre_er1octet : std_logic_vector(7 downto 0);

	
begin
	process(clk, rst)
		variable cpt_wait : natural := 10;
		variable num_octet : natural := 0;
	begin
		if(rst = '0') then
		-- on met toutes les variables à leur valeur par defaut
			etat <= idle;
			cpt_wait := 10;
			en_er <= '0';
			num_octet := 0;
			busy <= '0';
			ss <= '1';

		elsif(rising_edge(clk)) then
			case etat is
				when idle => 
					if (en = '1') then
						-- on met toutes les variables à leur valeur par defaut
						cpt_wait := 10;
						num_octet := 0;
						en_er <= '0';
						ss <= '0';
						busy <= '1';			
						-- on passe à l'état waiting
						etat <= waiting;
				end if;
					
				when waiting => 
					if (cpt_wait = 1) then -- on attend 10 clock d'horloge

						-- on case pour savoir quel octet on doit envoyer
						case num_octet is
							when 0 =>
								entre_er1octet <= v1;
							when 1 =>
								entre_er1octet <= v2;
							when 2 =>
								entre_er1octet <= "00000000"; -- valeur par defaut pas utilisee
							when others =>
						end case;
						
						en_er <= '1'; -- on commence à envoyer
						etat <= etat_er_1octet; -- on passe à l'etat etat_er_1octet						
					
					else
							cpt_wait := cpt_wait -1; -- sinon on decremente
					end if;
					
				when etat_er_1octet => 
					en_er <= '0'; -- permet d'avoir 1 pour valeur sur un seul top d'horloge

					--si on a fini d'envoyer et de recevoir
					if ((busy_er = '0') and (en_er = '0')) then
						case num_octet is -- on met la valeur dans la bonne variable
							when 0 =>
								val_xor <= sortie_er1octet;
							when 1 =>
								val_and <= sortie_er1octet;
							when 2 =>
								val_or <= sortie_er1octet;
							when others =>
						end case;
						
						--on teste si on a fini
						if (num_octet = 2) then
							busy <= '0'; -- on a fini 
							ss <= '1'; -- on reset le slave
							etat <= idle; -- on repasse à l'etat idle
						else
							cpt_wait := 3; -- on remet le conteur 
							num_octet := num_octet +1; -- on passe à l'octet suivant
							etat <= waiting; -- on repart dans l'etat waiting
						end if;

					end if;
			end case;
		end if;
	end process;
	
	-- appel au module er_1octet
	Inst_er_1octet: er_1octet PORT MAP(
		rst => rst,
		clk => clk,
		en => en_er,
		din => entre_er1octet,
		miso => miso,
		sclk => sclk,
		mosi => mosi,
		dout => sortie_er1octet,
		busy => busy_er
	);





end behavior;
