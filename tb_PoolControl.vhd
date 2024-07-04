library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_PoolControl is
end tb_PoolControl;

architecture testbench of tb_PoolControl is
    -- Signals for ports
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal set_TMAX, set_TMIN, set_ALT, PARAM, PC : std_logic := '0';
    signal TMAX, TMIN, T_SENSOR, ALT, ALT_SENSOR : std_logic_vector(2 downto 0) := "000";
    signal BC, BA, LAD : std_logic;
    signal TMAX_LED, TMIN_LED, T_SENSOR_LED, ALT_LED, ALT_SENSOR_LED : std_logic_vector(2 downto 0);
    
    -- Clock process
    constant PERIOD : time := 10 ns; -- Example clock period
    
begin

    -- Instantiate the DUT (Device Under Test)
    DUT : entity work.PoolControl
        port map (
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
        
    -- Clock process
    process
    begin
        while now < 1000 ns loop  -- Simulation duration
            clock <= '0';
            wait for PERIOD / 2;
            clock <= '1';
            wait for PERIOD / 2;
        end loop;
        wait;
    end process;
    
    -- Stimulus process
    stimulus : process
    begin
        reset <= '1';  -- Assert reset
        wait for 20 ns;
        reset <= '0';  -- De-assert reset
        
        -- Example stimulus
        set_TMAX <= '1';
        TMAX <= "101";  -- Example values
        wait for 20 ns;
        
        set_TMAX <= '0';
        set_TMIN <= '1';
        TMIN <= "010";  -- Example values
        wait for 20 ns;
        
        set_TMIN <= '0';
        set_ALT <= '1';
        ALT <= "110";   -- Example values
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
        
        
        -- Add more stimulus as needed
        
        wait;
    end process;

end testbench;