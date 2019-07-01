library ieee;
use ieee.std_logic_1164.all;

package muse is
  type figure is array (integer range <>) of integer range 0 to 9;
end muse;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;   
use work.muse.all;

entity numdisplay is
port(
	clk2,switch,clear,check,stay,breath,over,pass,flashstate:in std_logic;
    checkcat:in integer range 0 to 7; 
    seven:out std_logic_vector(6 downto 0);
    cat:out std_logic_vector(7 downto 0);
    shownum:in figure(3 downto 0)
	);
end numdisplay;

architecture num of numdisplay is

begin

p1:process(switch,clear,clk2)                            --modelu of time and score display
variable state:integer range 0 to 3:=0;
begin                    
    if   switch='0' then cat<="11111111";state:=0;
    elsif clear='1' then cat<="11111111";state:=0;
    elsif clk2'event and clk2='1' then
        if (check='1') then                                     --to check
            seven<="1111111";cat<="11111111";cat(checkcat)<='0';
        elsif(check='0' and stay='1') then                      --to stay dark
            cat<="11111111";
        elsif(check='0' and over='0'and breath='0') then          --while you are playing
			state:=state+1;
            case state is
             when 3=>cat<="11111101";
			 when 2=>cat<="11111110";
			 when 1=>cat<="01111111";
			 when 0=>cat<="10111111";
            end case;
		    case shownum(state) is
			 when 0=>seven<="1111110";
			 when 1=>seven<="0110000";
			 when 2=>seven<="1101101";
			 when 3=>seven<="1111001";
			 when 4=>seven<="0110011";
			 when 5=>seven<="1011011";
			 when 6=>seven<="1011111";
			 when 7=>seven<="1110000";
			 when 8=>seven<="1111111";
			 when 9=>seven<="1111011";
			 when others=>seven<="0000000";
            end case;
        elsif(over='1'and pass='1') then          --after you win 
            state:=state+1;
           if(flashstate='1') then
             case state is
              when 3=>cat<="11111111";
	          when 2=>cat<="11111111";
			  when 1=>cat<="01111111";
			  when 0=>cat<="10111111";
			 end case;
		   elsif(flashstate='0') then
             case state is
              when 3=>cat<="11111101";
	          when 2=>cat<="11111110";
			  when 1=>cat<="01111111";
			  when 0=>cat<="10111111";
             end case;
           end if;
		    case shownum(state) is
			 when 0=>seven<="1111110";
			 when 1=>seven<="0110000";
			 when 2=>seven<="1101101";
			 when 3=>seven<="1111001";
			 when 4=>seven<="0110011";
			 when 5=>seven<="1011011";
			 when 6=>seven<="1011111";
			 when 7=>seven<="1110000";
			 when 8=>seven<="1111111";
			 when 9=>seven<="1111011";
			 when others=>seven<="0000000";
			end case;
	    elsif(over='1'and pass='0') then          --after you lose
            state:=state+1;
           if(flashstate='1') then
             case state is
              when 3=>cat<="11111101";
	          when 2=>cat<="11111110";
			  when 1=>cat<="11111111";
			  when 0=>cat<="11111111";
			 end case;
		   elsif(flashstate='0') then
             case state is
              when 3=>cat<="11111101";
	          when 2=>cat<="11111110";
			  when 1=>cat<="01111111";
			  when 0=>cat<="10111111";
             end case;
           end if;
		    case shownum(state) is
			 when 0=>seven<="1111110";
			 when 1=>seven<="0110000";
			 when 2=>seven<="1101101";
			 when 3=>seven<="1111001";
			 when 4=>seven<="0110011";
			 when 5=>seven<="1011011";
			 when 6=>seven<="1011111";
			 when 7=>seven<="1110000";
			 when 8=>seven<="1111111";
			 when 9=>seven<="1111011";
			 when others=>seven<="0000000";
			end case;
		end if;
     end if;
end process;

end num;
  
