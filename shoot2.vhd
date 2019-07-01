library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity shoot2 IS
	port(
       clk,switch1,clear2:in std_logic;   --clock and the switch which turns on the system 
       speedup2,speeddown2:in std_logic;  --control the speed of the bullet
       fprtmove2,fplftmove2:in std_logic; --control the coordinates of the firing position
       fire3:in std_logic;
       fire2:in std_logic;                --shoot!
       usual2:in std_logic;               --if usual targer shows up 
       random2:in std_logic;              --if random target shows up
       beep_out:out std_logic;
       seven_out:out std_logic_vector(6 downto 0);     --number
       cat_out:out std_logic_vector(7 downto 0);       
       row1_out,col1_out:out std_logic_vector(7 downto 0); --row and column coordinates of the red dots matrix
       col2_out:out std_logic_vector(7 downto 0));     --column coordinates of the green dots matrix
end shoot2;

architecture top of shoot2 is

type dots is array (integer range <>) of integer range 0 to 7;  --array type:integer which varies from 0 to 7
type figure is array (integer range <>) of integer range 0 to 9;--array type:integer which varies from 0 to 9
 
component frequency_divider
port(
	clk_in,clear,switch:in std_logic;
	clk1,clk2,clk3,clk4,clk5:out std_logic);
end component;

component mxdisplay
port(
	clk3,clear,switch,check,breath,stay,over,pass,ishit,blout:in std_logic;
	checkrow,blr,blc:in integer range 0 to 7;
	fpc,fpr:in dots(3 downto 0);
	cntbreath:in integer range 0 to 29;
	tgtc:in dots(2 downto 0);   
    tgtr:in dots(2 downto 0);
	row1,col1,col2:out std_logic_vector(7 downto 0)
	);
end component;

component antishake
port (clear,speedup,speeddown,random,usual,fprtmove,fplftmove,fire,clk3:in std_logic;
        clear3,speedup3,speeddown3,random3,usual3,fprtmove3,fplftmove3,fire3:out std_logic);
end component;
                       
                       
component numdisplay
port(
	clk2,switch,clear,check,stay,breath,over,pass,flashstate:in std_logic;
    checkcat:in integer range 0 to 7; 
    seven:out std_logic_vector(6 downto 0);
    cat:out std_logic_vector(7 downto 0);
    shownum:in figure(3 downto 0)
	);
end component;

component statecontrol
port(
	clk4,switch,clear:in std_logic;
    check,stay,breath,flashstate:out std_logic;
    checkcat,checkrow:out integer range 0 to 7; 
    cntbreath:out integer range 0 to 29
	);
end component;

component gamecontrol
port(
	clk4,clk1,clk5,fire,fire2,switch,clear,speedup,speeddown,random,usual,fprtmove,fplftmove,breath:in std_logic;
    tgtc:out dots(2 downto 0);   
    tgtr:out dots(2 downto 0);
    blr,blc:out integer range 0 to 7;
    fpc:out dots(3 downto 0);
    shownum:out figure(3 downto 0);
    blout,ishit,over,pass:out std_logic
	);
end component;

component musicplayer
port(
     switch,CLK,check,stay,over,pass:in std_logic;
     beep:out std_logic
     );
end component;

signal clear1,speedup1,speeddown1,random1,usual1,fprtmove1,fplftmove1,fire1: std_logic;
signal clk_1,clk_2,clk_3,clk_4,clk_5: std_logic;
signal check_out,stay_out,breath_out,over_out,pass_out,ishit_out,blout_out: std_logic;
signal checkrow_out,blr_out,blc_out:integer range 0 to 7 ;
constant fpr_out:dots(3 downto 0):=(0,0,0,1);
signal tgtc_out:dots(2 downto 0); 
signal tgtr_out:dots(2 downto 0);   
signal fpc_out:dots(3 downto 0);
signal flashstate_out:std_logic;      
signal shownum_out:figure(3 downto 0);
signal checkcat_out:integer range 0 to 7;
signal cntbreath_out: integer range 0 to 29;     

begin
u1:frequency_divider port map(clk_in=>clk,clear=>clear1,switch=>switch1,clk1=>clk_1,clk2=>clk_2,clk3=>clk_3,clk4=>clk_4,clk5=>clk_5);
u2:mxdisplay port map(clk3=>clk_3,clear=>clear1,switch=>switch1,check=>check_out,breath=>breath_out,stay=>stay_out,over=>over_out,
                      pass=>pass_out,ishit=>ishit_out,blout=>blout_out,checkrow=>checkrow_out,blr=>blr_out,blc=>blc_out,
                      fpc=>fpc_out,fpr=>fpr_out,cntbreath=>cntbreath_out,tgtr=>tgtr_out,tgtc=>tgtc_out,
                      row1=>row1_out,col1=>col1_out,col2=>col2_out);
u3:numdisplay port map(clk2=>clk_2,switch=>switch1,clear=>clear1,check=>check_out,stay=>stay_out,breath=>breath_out,over=>over_out
                     ,pass=>pass_out,flashstate=>flashstate_out,checkcat=>checkcat_out,seven=>seven_out,cat=>cat_out,shownum=>shownum_out);
u4:statecontrol port map(clk4=>clk_4,switch=>switch1,clear=>clear1,check=>check_out,stay=>stay_out,breath=>breath_out
                     ,flashstate=>flashstate_out,checkcat=>checkcat_out,checkrow=>checkrow_out,cntbreath=>cntbreath_out);
u5:gamecontrol port map(clk4=>clk_4,clk1=>clk_1,clk5=>clk_5,fire=>fire2,fire2=>fire3,switch=>switch1,clear=>clear1,speedup=>speedup2,speeddown=>speeddown2
                      ,random=>random2,usual=>usual2,fplftmove=>fplftmove2,fprtmove=>fprtmove2,tgtc=>tgtc_out,tgtr=>tgtr_out,blr=>blr_out,blc=>blc_out,fpc=>fpc_out,
                       shownum=>shownum_out,blout=>blout_out,ishit=>ishit_out,over=>over_out,pass=>pass_out,breath=>breath_out);
u6:antishake port map(clk3=>clk_3,clear=>clear2,speedup=>speedup2,speeddown=>speeddown2,random=>random2,usual=>usual2,fprtmove=>fprtmove2
                     ,fplftmove=>fplftmove2,fire=>fire2,clear3=>clear1,speedup3=>speedup1,speeddown3=>speeddown1,random3=>random1
                      ,usual3=>usual1,fprtmove3=>fprtmove1,fplftmove3=>fplftmove1,fire3=>fire1);
u7:musicplayer port map(switch=>switch1,CLK=>clk,check=>check_out,stay=>stay_out,over=>over_out,pass=>pass_out,beep=>beep_out
                         );
end top;