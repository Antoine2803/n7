library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Nexys4Joystick is
  port (
    -- les 16 switchs
    swt : in std_logic_vector (15 downto 0);
    -- les 5 boutons noirs
    btnC, btnU, btnL, btnR, btnD : in std_logic;
    -- horloge
    mclk : in std_logic;
    -- les 16 leds
    led : out std_logic_vector (15 downto 0);
    -- les anodes pour sélectionner les afficheurs 7 segments à utiliser
    an : out std_logic_vector (7 downto 0);
    -- valeur affichée sur les 7 segments (point décimal compris, segment 7)
    ssg : out std_logic_vector (7 downto 0);
		ss : out std_logic;
		mosi : out std_logic;
		miso : in std_logic;
		sck : out std_logic
  );
end Nexys4Joystick;

architecture synthesis of Nexys4Joystick is

	COMPONENT MasterJoystick
	PORT(
		rst : IN std_logic;
		clk : IN std_logic;
		en : IN std_logic;
		miso : IN std_logic;
		inLed1 : IN std_logic;
		inLed2 : IN std_logic;          
		sclk : OUT std_logic;
		ss : OUT std_logic;
		mosi : OUT std_logic;
		x : OUT std_logic_vector(9 downto 0);
		y : OUT std_logic_vector(9 downto 0);
		btn_joy : OUT std_logic;
		btn1 : OUT std_logic;
		btn2 : OUT std_logic;
		busy : OUT std_logic
		);
	END COMPONENT;

	COMPONENT All7Segments
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		e0 : IN std_logic_vector(3 downto 0);
		e1 : IN std_logic_vector(3 downto 0);
		e2 : IN std_logic_vector(3 downto 0);
		e3 : IN std_logic_vector(3 downto 0);
		e4 : IN std_logic_vector(3 downto 0);
		e5 : IN std_logic_vector(3 downto 0);
		e6 : IN std_logic_vector(3 downto 0);
		e7 : IN std_logic_vector(3 downto 0);          
		an : OUT std_logic_vector(7 downto 0);
		ssg : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	signal x : std_logic_vector (9 downto 0);	-- signal x recu du joystick
	signal y : std_logic_vector (9 downto 0); -- signal y recu du joystick
	signal busy : std_logic; -- signal busy de masterJoystick qui n'est pas utilisé
	signal rst : std_logic; -- signal reset

begin
	-- reset bind sur le bouton du centre
	rst <= not btnC;

	-- leds pas utilisées a 0
  led(15 downto 3) <= (others => '0');

	Inst_MasterJoystick: MasterJoystick PORT MAP(
		rst => rst,
		clk => mclk,
		en => '1',
		miso => miso,
		inLed1 => btnL,
		inLed2 => btnR,
		sclk => sck,
		ss => ss,
		mosi => mosi,
		x => x,
		y => y,
		btn_joy => led(0),
		btn1 => led(1),
		btn2 => led(2),
		busy => busy
	);
	
	
	Inst_All7Segments: All7Segments PORT MAP(
		clk => mclk,
		reset => rst,
		e0 => x(3 downto 0),
		e1 => x(7 downto 4),
		e2 => "00" & x(9 downto 8),
		e3 => "0000",
		e4 => y(3 downto 0),
		e5 => y(7 downto 4),
		e6 => "00" & y(9 downto 8),
		e7 => "0000",
		an => an,
		ssg => ssg
	);

    
end synthesis;
