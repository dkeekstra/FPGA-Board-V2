-- Edited by Bert Molenkamp
-- removed the synopsys (non-IEEE libraries): std_logic_arith and std_logic_unsigned
-- in "case sws is" you alread know that sws(0) is '1' so with that information rgbc<=ses(3 downto 1)
-- increment of rgbc can be replaced with MOD 2**length
-- same for bugc 
-- Libery's:

library ieee;

use ieee.std_logic_1164.all;
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
signal bufc :unsigned(7 downto 0);
signal rgbc :unsigned(2 downto 0);

begin

  leds <= std_logic_vector(bufc);
    
  RGB <= std_logic_vector(rgbc);
    
  process (clk, reset)
    begin
    if(reset = '1') then
        rgbc <= "000";
        bufc <= "00000000";
    elsif (clk'event and clk = '1') then
      if(sws(0) = '1') then
        rgbc <= unsigned(sws(3 downto 1));
        bufc <= unsigned( btns & btns);
      else
        if (counter = 10000000) then
          counter <= 0;
          bufc <= bufc + 1 MOD (2**bufc'LENGTH); 
          rgbc <= rgbc + 1 MOD (2**rgbc'LENGTH); 
        else
          counter <= counter + 1;
        end if;
      end if;
    end if; 
  end process;

end Behave;