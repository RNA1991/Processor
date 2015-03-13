--------------------------------------------------------------
-- 
-- Clock driven Memory (results in 1 clockcycle delay) 
--
--------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY memory IS
	PORT(
		address_bus	: IN  std_logic_vector(31 DOWNTO 0);
		databus_in	: IN  std_logic_vector(31 DOWNTO 0);
		databus_out : OUT std_logic_vector(31 DOWNTO 0);
		read		: IN  std_logic;
		write 		: IN  std_logic;	
		clk			: IN  std_logic
	);
END memory;

ARCHITECTURE behaviour OF memory IS

BEGIN
	PROCESS(clk)
		CONSTANT low_address	: INTEGER := 0; 
		CONSTANT high_address	: INTEGER := 256;

		TYPE mem_array IS ARRAY (low_address TO high_address) OF std_logic_vector(31 DOWNTO 0);

		VARIABLE address 	: INTEGER;
		VARIABLE mem 		: mem_array := 
				   ("00110100000000100000000000011001",
					"00110100000000110000000000110010",
					"00110100000001000000000001100100",
					"00110100000001010000000010010110",
					"00110100000001100000000011001000",
					"00110100000001110000000100101100",
					"00110100000010000000000111110100",
					"10101100000000100000000011111001",
					"10101100000000110000000011111010",
					"10101100000001000000000011111011",
					"10101100000001010000000011111100",
					"10101100000001100000000011111101",
					"10101100000001110000000011111110",
					"10101100000010000000000011111111",
					"10001100000000100000000011111001",
					"10001100000000110000000011111010",
					"10001100000001000000000011111011",
					"10001100000001010000000011111100",
					"10001100000001100000000011111101",
					"10001100000001110000000011111110",
					"10001100000010000000000011111111",
					"00000000010000110010000000100000",
					"00100000101001100000000000110010",
					"00000000110001110100000000100100",
					"00110000001000101010101010101010",
					"00010000011001000000000000000001",
					"00010000011001000000000000000000",
					"00011100110000000000000000000001",
					"00011100110000000000000000000000",
					"00000001000001110000000000011011",
					"00000000000000000011100000010000",
					"00000000000000000100000000010010",
					"00000000010000110000000000011000",
					"00000000000000000001000000010000",
					"00000000000000000001100000010010",
					"00000000000000000000000000000000",
					"00000000000000000000000000000000",
					"10101100000000100000000011111001",
					"10101100000000110000000011111010",
					"10101100000001000000000011111011",
					"10101100000001010000000011111100",
					"10101100000001100000000011111101",
					"10101100000001110000000011111110",
					"10101100000010000000000011111111",
					"00001000000100000000000000001110",
				    OTHERS => "00000000000000000000000000000000"
					);

	BEGIN
		IF rising_edge(clk) THEN
			address :=  to_integer(unsigned(address_bus(31 DOWNTO 2)));

			IF write = '1' THEN
				mem(address) := databus_in;
			ELSE 
				-- Read instruction
				databus_out  <= mem(address);
			END IF;
		END IF;
	END PROCESS;

END ARCHITECTURE;

