library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity trivium_testbench is
end trivium_testbench;

architecture beh of trivium_testbench is
  signal t_clk, t_ready, t_cipher, t_decipher, t_start : std_logic := '0';
  signal t_reset : std_logic := '0';
  signal t_input : std_logic := '1';
  signal t_K  : std_logic_vector(79 downto 0) := x"00000000000000000000"; 
  signal t_IV : std_logic_vector(79 downto 0) := x"00000000000000000000";  
  
  component trivium_module
    port (clk, start, reset : in std_logic;
      K, IV : in std_logic_vector(79 downto 0);
      input : in std_logic;
      ready, output : out std_logic);
  end component;

begin
  Trivium_Module_encipher : trivium_module port map(t_clk, t_start, t_reset, t_K, t_IV, t_input, t_ready, t_cipher);
  Trivium_Module_decipher : trivium_module port map(t_clk, t_start, t_reset, t_K, t_IV, t_cipher, t_ready, t_decipher);
    
  clk_gen: process
  begin
    t_clk <= '1';
    wait for 1 ns;
    t_clk <= '0';
    wait for 1 ns;
  end process clk_gen;
  
  t_start <= '1', '0' after 90 ns, '1' after 200 ns, '0' after 290 ns; 
  t_input <= '0';
  t_reset <= '0', '1' after 180 ns, '0' after 200 ns;

end beh;