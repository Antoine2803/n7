library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity er_1octet is
  port ( rst : in std_logic ;
         clk : in std_logic ;
         en : in std_logic ;
         din : in std_logic_vector (7 downto 0) ;
         miso : in std_logic ;
         sclk : out std_logic ;
         mosi : out std_logic ;
         dout : out std_logic_vector (7 downto 0) ;
         busy : out std_logic);
end er_1octet;

architecture behavioral of er_1octet is
	type t_etat is (idle, reception, envoi);
  signal etat : t_etat;
begin
	process(clk, rst)
		variable rg_din : std_logic_vector (7 downto 0);
		variable cpt_bit : natural;
	begin
		if(rst = '0') then
			-- sur rst on met les variables a leur valeurs par defaut
			sclk <= '1';
			etat <= idle;
			busy <= '0';
			rg_din := (others => 'U');
		elsif(rising_edge(clk)) then
			case etat is
				when idle =>
					if (en = '1') then 
						-- si on lance le composant on met les vriables aux bonne valeurs
						busy <= '1';
						sclk <= '0';
						rg_din := din;
						cpt_bit := 7;
						mosi <= rg_din(cpt_bit);
						etat <= reception; -- on passe à l'etat reception
					end if;
					
				when reception =>
				
					if (cpt_bit = 0) then 
						sclk <= '1'; --on fait tourner la seconde clock
						rg_din(cpt_bit) := miso; -- on enregistre la valeur recue
						busy <= '0'; -- on a fini
						dout <= rg_din; -- on recupere la valeur de sortie
						etat <= idle; -- on repart a l'etat idle
					else
						sclk <= '1'; --on fait tourner la seconde clock
						rg_din(cpt_bit) := miso; -- on enregistre la valeur recue
						etat <= envoi;-- on repart dans l'etat envoi
					end if;
					
				when envoi =>
				
					sclk <= '0'; --on fait tourner la seconde clock
					cpt_bit := cpt_bit -1; -- on traite le bit suivant
					mosi <= rg_din(cpt_bit); -- on recupere le bit suivant a envoyer
					etat <= reception; -- on passe en reception
					
				end case;
		end if;
	end process;
end behavioral;
