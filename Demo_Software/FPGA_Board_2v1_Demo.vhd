-- Libery's:
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
--Entity:
entity FPGA_Board_2v1_Demo is
	Port(clk : in std_logic;
		reset : in std_logic;
		btns: in std_logic_vector(3 downto 0);
		sws: in std_logic_vector(3 downto 0);
		leds: out std_logic_vector(7 downto 0);
		RGB: out std_logic_vector(2 downto 0));
end FPGA_Board_2v1_Demo;

architecture Behave of FPGA_Board_2v1_Demo is
signal counter : integer range 0 to 10000000 := 0;
signal bufc :std_Logic_vector(7 downto 0);
signal rgbc :std_Logic_vector(2 downto 0);

begin
	leds <= bufc;
	RGB <= rgbc;
	process (clk, reset)
		begin
		if(reset = '1') then
				rgbc <= "000";
				bufc <= "00000000";
		elsif (clk'event and clk = '1') then
			if(sws(0) = '1') then
				case sws is 
					when "0001" =>
						rgbc <= "000";
					when "0011" =>
						rgbc <= "001";
					when "0101" =>
						rgbc <= "010";
					when "1001" =>
						rgbc <= "100";
					when "0111" =>
						rgbc <= "011";
					when "1011" =>
						rgbc <= "101";
					when "1101" =>
						rgbc <= "110";
					when "1111" =>
						rgbc <= "111";
					when others =>
						rgbc <= "000";
				end case;

				bufc <=  btns & btns;
	
			else
				if (counter = 10000000) then
					counter <= 0;
					
					if (bufc = "11111111") then
						bufc <= "00000000";
					else
						bufc <= bufc + 1;
					end if;
					
					if(rgbc = "111") then
						rgbc <= "000";
					else
						rgbc <= rgbc + 1;
					end if;
					
				else
					counter <= counter + 1;
				end if;
			end if;
		end if; 
	end process;
		
		
end Behave;