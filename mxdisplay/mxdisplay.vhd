library ieee;
use ieee.std_logic_1164.all;

package muse1 is
  type dots is array (integer range <>) of integer range 0 to 7;
end muse1;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;   
use work.muse1.all;


entity mxdisplay is

port(
	clk3,clear,switch,check,breath,stay,over,pass,ishit,blout:in std_logic;
	checkrow,blr,blc:in integer range 0 to 7;
	fpc,fpr:in dots(3 downto 0);
	cntbreath:in integer range 0 to 29;
	tgtc:in dots(2 downto 0);   
    tgtr:in dots(2 downto 0);
	row1,col1,col2:out std_logic_vector(7 downto 0)
	);
end mxdisplay;

architecture mx of mxdisplay is

 signal point:integer range 0 to 7; 

begin

p1:process(switch,clear,clk3)                            --module of dot matrix display
variable temp1:integer range 0 to 29;


    begin
    if switch='0' then
        row1<="11111111";
		col1<="00000000";
		col2<="00000000";
		point<=0;
    elsif clear='1' then
		row1<="11111111";
		col1<="00000000";
		col2<="00000000";
	    point<=0;
	elsif clk3'event and clk3='1' then
              if (check='1') then                      --to check
                  row1<="11111111";
		          col1<="00000000";
		          col2<="00000000";
                  row1(checkrow)<='0'; col1<="11111111";
		          col2<="00000000";	
		      elsif (check='0' and stay='1') then      --to stay dark
                  row1<="11111111";
		          col1<="00000000";
		          col2<="00000000";
		      elsif (check='0' and breath='1')  then                     --to breath
                  row1<="11111111";
		          col1<="00000000";
		          col2<="00000000";
		          temp1:=temp1+1;
		        if(temp1<cntbreath) then
		                if point=7 then
		                point<=0;
		                else point<=point+1;
                        end if;
                     case point is
				     when 0|1|2|3=> row1(fpr(point))<='0';    --show the firing position
							     col2(fpc(point))<='1';
				     when others=>   row1<="11111111";col1<="00000000";col2<="00000000";
				     end case;
				  end if;
              elsif (check='0' and over='0' and breath='0' ) then                     --while you are playing
                  row1<="11111111";
		          col1<="00000000";
		          col2<="00000000";
                        if point=7 then
		                point<=0;
		                else point<=point+1;
                        end if;
                  case point is
				  when 0|1|2|3=> row1(fpr(point))<='0';        --show the firing position
							     col2(fpc(point))<='1';
				  when 4=> if(blout='1' and ishit='0')   then  --show the bullet
				             if(blr=tgtr(0) and (blc=tgtc(0) or blc=tgtc(1) or blc=tgtc(2))) then  
                             row1(blr)<='0';  col2(blc)<='1';
                             else row1(blr)<='0';  col1(blc)<='1';
                             end if; 
                           end if;
                  when 5|6|7=> row1(tgtr(point-5))<='0';     --show the target
                         col1(tgtc(point-5))<='1';
                  when others=>col1<="00000000";row1<="11111111";
                               col2<="00000000";
                  end case;               
              elsif (over ='1' and pass='1' ) then           --after you win
		          row1<="11111111";
		          col1<="00000000";
		          col2<="00000000";
		                if point=7 then
		                point<=0;
		                else point<=point+1;
                        end if;
                   case point is 
                   when 0=>row1<="01111111";col2<="00000000";
                   when 1=>row1<="10111111";col2<="10000000";
                   when 2=>row1<="11011111";col2<="11000000";
                   when 3=>row1<="11101111";col2<="01100011";
                   when 4=>row1<="11110111";col2<="00110110";
                   when 5=>row1<="11111011";col2<="00011100";
                   when 6=>row1<="11111101";col2<="00001000";
                   when 7=>row1<="11111110";col2<="00000000";
                   when others=>col1<="00000000";row1<="11111111";col2<="00000000";
                   end case;
              elsif (over ='1' and pass='0' ) then          --after you lose
		          row1<="11111111";
		          col1<="00000000";
		          col2<="00000000";
		                if point=7 then
		                point<=0;
		                else point<=point+1;
                        end if;
                   case point is 
                   when 0=>row1<="01111111";col1<="11000011";
                   when 1=>row1<="10111111";col1<="01100110";
                   when 2=>row1<="11011111";col1<="00111100";
                   when 3=>row1<="11101111";col1<="00011000";
                   when 4=>row1<="11110111";col1<="00111100";
                   when 5=>row1<="11111011";col1<="01100110";
                   when 6=>row1<="11111101";col1<="11000011";
                   when 7=>row1<="11111110";col1<="00000000";
                   when others=>col1<="00000000";row1<="11111111";col2<="00000000";
                   end case;
              end if; 
     end if;
end process;


end mx;
