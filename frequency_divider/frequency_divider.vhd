library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
	
entity frequency_divider is
   port(
	clk_in,clear,switch:in std_logic;
	clk1,clk2,clk3,clk4,clk5:out std_logic);
end frequency_divider;

architecture  fd of frequency_divider is   
  
  
  signal tmp1:integer range 0 to 24999999; --clk1 1Hz
  signal tmp2:integer range 0 to 49999;    --clk2 500Hz
  signal tmp3:integer range 0 to 24;       --clk3 1Mhz
  signal tmp4:integer range 0 to 2499999;  --clk4 10Hz
  signal tmp5:integer range 0 to  6249999; --clk5 4Hz
  signal clk1t,clk2t,clk3t,clk4t,clk5t:std_logic;
begin
    
p1:process(clk_in,clear,switch)                             --frequency divider
	begin 
		if clear='1' then
			tmp1<=0;tmp2<=0;tmp3<=0;tmp4<=0;tmp5<=0;
		elsif clk_in'event and clk_in='1'  then		    
			if (tmp1=24999999) then 
                tmp1<=0;clk1t<=not clk1t;
            else   tmp1<=tmp1+1;
            end if;           
                
            if (tmp2=49999) then 
                tmp2<=0;clk2t<=not clk2t;
            else   tmp2<=tmp2+1;
            end if;
                      
            if (tmp3=24) then 
                tmp3<=0;clk3t<=not clk3t;
            else   tmp3<=tmp3+1;
            end if;
            
            if (tmp4=2499999) then 
                tmp4<=0;clk4t<=not clk4t;
            else   tmp4<=tmp4+1;
            end if;
           
            if (tmp5=6249999) then 
                tmp5<=0;clk5t<=not clk5t;
            else   tmp5<=tmp5+1;
            end if;
                       
        end if;
end process;
clk1<=clk1t;
clk2<=clk2t;
clk3<=clk3t;
clk4<=clk4t;
clk5<=clk4t;
end fd;