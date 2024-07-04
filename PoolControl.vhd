library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Sequence detector for detecting the sequence "1011".
--Overlapping type.
entity PoolControl is
    Port ( 
			  clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           set_TMAX: in STD_LOGIC;
           TMAX: in STD_LOGIC_VECTOR(2 downto 0);
           set_TMIN: in STD_LOGIC;
           TMIN: in STD_LOGIC_VECTOR(2 downto 0);
           T_SENSOR : in STD_LOGIC_VECTOR(2 downto 0);
           set_ALT: in STD_LOGIC;
           ALT: in STD_LOGIC_VECTOR(2 downto 0);
           ALT_SENSOR: in STD_LOGIC_VECTOR(2 downto 0);
           PARAM: in STD_LOGIC;
           PC: in STD_LOGIC;
           BC: out STD_LOGIC;
           BA: out STD_LOGIC;
           LAD: out STD_LOGIC;
           TMAX_LED: out STD_LOGIC_VECTOR(2 downto 0);
           TMIN_LED: out STD_LOGIC_VECTOR(2 downto 0);
           T_SENSOR_LED: out STD_LOGIC_VECTOR(2 downto 0);
           ALT_LED: out STD_LOGIC_VECTOR(2 downto 0);
           ALT_SENSOR_LED: out STD_LOGIC_VECTOR(2 downto 0)
			  );
end PoolControl;
architecture Behavioral of PoolControl is
--Defines the type for states in the state machine
type state_type is (INIT, S_ALTURA, S_T_MAX, S_T_MIN, P_COBERTA, CHECK, BA_ON, LAD_ON, BC_ON);
--Declare the signal with the corresponding state type.
signal Current_State, Next_State : state_type;
signal TMAX_reg, TMIN_reg, ALT_reg : std_logic_vector(2 downto 0) := (others => '0');
begin
-- Synchronous Process
process(CLOCK)
begin
    if( reset = '1' ) then                 --Synchronous Reset
        Current_State <= INIT;
    elsif (CLOCK'event and CLOCK = '1') then   --Rising edge of Clock
        Current_State <= Next_State;
    end if;
end process;
-- Combinational Process
Process(Current_State, set_ALT,set_TMAX,set_TMIN, TMAX,TMIN,ALT,ALT_SENSOR,T_SENSOR,PC,PARAM)
    begin
        case Current_State is
            when INIT =>
					   BC <= '0';
					   BA <= '0';
					   LAD <= '0';
					   TMAX_LED <= TMAX_reg;
					   TMIN_LED <= TMIN_reg;
					   T_SENSOR_LED <= T_SENSOR;
					   ALT_LED <= ALT_reg;
						ALT_SENSOR_LED <= ALT_SENSOR;
						if set_TMAX = '1' and set_ALT = '0' and set_TMIN = '0' then
							Next_State <= S_T_MAX;
						elsif set_TMAX = '0' and set_ALT = '0' and set_TMIN = '1' then
							Next_State <= S_T_MIN;
						elsif set_TMAX = '0' and set_ALT = '1' and set_TMIN = '0' then
							Next_State <= S_ALTURA;
						elsif PARAM = '1' then
							Next_State <= P_COBERTA;
						else
							Next_State <= INIT;
						end if;
							
				when S_T_MAX =>
				
							TMAX_reg <= TMAX;
						   BC <= '0';
							BA <= '0';
							LAD <= '0';
							TMAX_LED <= TMAX_reg;
							TMIN_LED <= TMIN_reg;
							T_SENSOR_LED <= T_SENSOR;
							ALT_LED <= ALT_reg;
							ALT_SENSOR_LED <= ALT_SENSOR;
						   if set_TMAX = '1' then
							  Next_State <= S_T_MAX;
							else
								Next_State <= INIT;
							end if;
							
				when S_T_MIN =>
							
						   TMIN_reg <= TMIN;
						   BC <= '0';
							BA <= '0';
							LAD <= '0';
							TMAX_LED <= TMAX_reg;
							TMIN_LED <= TMIN_reg;
							T_SENSOR_LED <= T_SENSOR;
							ALT_LED <= ALT_reg;
							ALT_SENSOR_LED <= ALT_SENSOR;
						   if set_TMIN = '1' then
							  Next_State <= S_T_MIN;
							else
								Next_State <= INIT;
							end if;
				when S_ALTURA =>
							
						   ALT_reg <= ALT;
						   BC <= '0';
							BA <= '0';
							LAD <= '0';
							TMAX_LED <= TMAX_reg;
							TMIN_LED <= TMIN_reg;
							T_SENSOR_LED <= T_SENSOR;
							ALT_LED <= ALT_reg;
							ALT_SENSOR_LED <= ALT_SENSOR;
						   if set_ALT = '1' then
							  Next_State <= S_ALTURA;
							else
								Next_State <= INIT;
							end if;
							
				when P_COBERTA =>
							
						   BC <= '0';
							BA <= '0';
							LAD <= '0';
							TMAX_LED <= TMAX_reg;
							TMIN_LED <= TMIN_reg;
							T_SENSOR_LED <= T_SENSOR;
							ALT_LED <= ALT_reg;
							ALT_SENSOR_LED <= ALT_SENSOR;
						   ALT_SENSOR_LED <= ALT_SENSOR;
							if PARAM = '0' then
								Next_State <= INIT;
							elsif PC = '0' then
								Next_State <= CHECK;
							else
								Next_State <= P_COBERTA;
							end if;
							
				when CHECK =>
						   BC <= '0';
							BA <= '0';
							LAD <= '0';
							TMAX_LED <= TMAX_reg;
							TMIN_LED <= TMIN_reg;
							T_SENSOR_LED <= T_SENSOR;
							ALT_LED <= ALT_reg;
							ALT_SENSOR_LED <= ALT_SENSOR;
							if ALT_SENSOR < ALT_reg then
								Next_State <= BA_ON;
							elsif ALT_SENSOR > ALT_reg then
								Next_State <= LAD_ON;
							elsif T_SENSOR < TMIN_reg then
								Next_State <= BC_ON;
							else
								Next_State <= CHECK;
							end if;
				
				when BA_ON =>
				
							BC <= '0';
							BA <= '1';
							LAD <= '0';
							TMAX_LED <= TMAX_reg;
							TMIN_LED <= TMIN_reg;
							T_SENSOR_LED <= T_SENSOR;
							ALT_LED <= ALT_reg;
							ALT_SENSOR_LED <= ALT_SENSOR;
							
							if ALT_SENSOR >= ALT_reg then
								Next_State <= CHECK;
							else
								Next_State <= BA_ON;
							end if;
							
				when BC_ON =>
				
							BC <= '1';
							BA <= '0';
							LAD <= '0';
							TMAX_LED <= TMAX_reg;
							TMIN_LED <= TMIN_reg;
							T_SENSOR_LED <= T_SENSOR;
							ALT_LED <= ALT_reg;
							ALT_SENSOR_LED <= ALT_SENSOR;
							
							if T_SENSOR >= TMAX_reg then
								Next_State <= CHECK;
							else
								Next_State <= BC_ON;
							end if;
							
				when LAD_ON =>
				
							BC <= '0';
							BA <= '0';
							LAD <= '1';
							TMAX_LED <= TMAX_reg;
							TMIN_LED <= TMIN_reg;
							T_SENSOR_LED <= T_SENSOR;
							ALT_LED <= ALT_reg;
							ALT_SENSOR_LED <= ALT_SENSOR;
							
							if ALT_SENSOR <= ALT_reg then
								Next_State <= CHECK;
							else
								Next_State <= LAD_ON;
							end if;
        end case;
end process;   
end Behavioral;