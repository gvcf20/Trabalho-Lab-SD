library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_PoolControl is
end tb_PoolControl;

architecture testbench of tb_PoolControl is
    
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
	 signal start : std_logic := '0';
    signal set_TMAX, set_TMIN, set_ALT, PARAM, PC : std_logic := '0';
    signal TMAX, TMIN, T_SENSOR, ALT, ALT_SENSOR : std_logic_vector(2 downto 0) := "000";
    signal BC, BA, LAD : std_logic;
    signal TMAX_LED, TMIN_LED, T_SENSOR_LED, ALT_LED, ALT_SENSOR_LED : std_logic_vector(2 downto 0);
    
   
    constant PERIOD : time := 10 ns;
    
begin

    DUT : entity work.PoolControl
        port map (
				start => start,
            clock => clock,
            reset => reset,
            set_TMAX => set_TMAX,
            TMAX => TMAX,
            set_TMIN => set_TMIN,
            TMIN => TMIN,
            T_SENSOR => T_SENSOR,
            set_ALT => set_ALT,
            ALT => ALT,
            ALT_SENSOR => ALT_SENSOR,
            PARAM => PARAM,
            PC => PC,
            BC => BC,
            BA => BA,
            LAD => LAD,
            TMAX_LED => TMAX_LED,
            TMIN_LED => TMIN_LED,
            T_SENSOR_LED => T_SENSOR_LED,
            ALT_LED => ALT_LED,
            ALT_SENSOR_LED => ALT_SENSOR_LED
        );
        
    process
    begin
        while now < 1000 ns loop 
            clock <= '0';
            wait for PERIOD / 2;
            clock <= '1';
            wait for PERIOD / 2;
        end loop;
        wait;
    end process;
    
    stimulus : process
    begin
        reset <= '0';  
        wait for 20 ns;
        reset <= '1';  
        wait for 20 ns;
        reset <= '0';
		  wait for 20 ns;
		  start <= '1';
		  wait for 20 ns;
        
        set_TMAX <= '1';
        TMAX <= "101"; 
        wait for 20 ns;
        
        set_TMAX <= '0';
        set_TMIN <= '1';
        TMIN <= "010"; 
        wait for 20 ns;
        
        set_TMIN <= '0';
        set_ALT <= '1';
        ALT <= "110";
        wait for 20 ns;
        
        set_ALT <= '0';
        PARAM <= '1';
        wait for 20 ns;
        
        PC <= '0';
        wait for 20 ns;
		  
		  ALT_SENSOR <= "110";
        wait for 20 ns;
        
        T_SENSOR <= "101";
        wait for 20 ns;
        
        ALT_SENSOR <= "111";
		  wait for 20 ns;
		  
		  ALT_SENSOR <= "001";
		  wait for 20 ns;
		  
		  PC <= '1';
		  wait for 20 ns;
		  
		  ALT_SENSOR <= "111";
		  T_SENSOR <= "111";
		  wait for 20 ns;
		  
		  reset <= '1';  
      wait for 20 ns;
		  
		  T_SENSOR <= "101";
		  wait for 20 ns;
		  
		  T_SENSOR <= "100";
		  wait for 20 ns;
		  
		  T_SENSOR <= "000";
		  wait for 20 ns;
		  
		  PC <= '1';
		  wait for 20 ns;
		  
		  PARAM <= '0';
        
     
        
        wait;
    end process;

end testbench;