Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
--use IEEE.std_logic_arith.all;
-- Designed by Yoshinao Kobayashi 20161225
entity TopCollatz is
end TopCollatz;
architecture SIM of TopCollatz is
    signal 		SysClk   :std_logic:= '0';
    signal		Go   :std_logic:= '0';
	 signal	 	OutMX1     : std_logic_vector(17 downto 0):=(others => '0');
	 signal		OutMX2     : std_logic_vector(17 downto 0):=(others => '0');
	 signal		OutMX3     : std_logic_vector(17 downto 0):=(others => '0');
	 signal		OutMX4     : std_logic_vector(17 downto 0):=(others => '0');
	 signal 		OutLEN1    : std_logic_vector(7 downto 0) :=(others => '0');
	 signal		OutLEN2    : std_logic_vector(7 downto 0) :=(others => '0');
	 signal		OutLEN3    : std_logic_vector(7 downto 0) :=(others => '0');
	 signal		OutLEN4    : std_logic_vector(7 downto 0) :=(others => '0');
	 signal		OutNAME1    : std_logic_vector(9 downto 0) :=(others => '0');
	 signal		OutNAME2    : std_logic_vector(9 downto 0) :=(others => '0');
	 signal		OutNAME3    : std_logic_vector(9 downto 0) :=(others => '0');
	 signal		OutNAME4    : std_logic_vector(9 downto 0) :=(others => '0');

    component Collatz
        port(
			SysClk  :in std_logic:='0';
			Go :in std_logic := '0';
	 		OutMX1     :out std_logic_vector(17 downto 0):=(others => '0');
	 		OutMX2     :out std_logic_vector(17 downto 0):=(others => '0');
	 		OutMX3     :out std_logic_vector(17 downto 0):=(others => '0');
	 		OutMX4     :out std_logic_vector(17 downto 0):=(others => '0');
	 		OutLEN1    :out std_logic_vector(7 downto 0) :=(others => '0');
	 		OutLEN2    :out std_logic_vector(7 downto 0) :=(others => '0');
	 		OutLEN3    :out std_logic_vector(7 downto 0) :=(others => '0');
	 		OutLEN4    :out std_logic_vector(7 downto 0) :=(others => '0');
	 		OutNAME1    :out std_logic_vector(9 downto 0) :=(others => '0');
	 		OutNAME2    :out std_logic_vector(9 downto 0) :=(others => '0');
	 		OutNAME3    :out std_logic_vector(9 downto 0) :=(others => '0');
	 		OutNAME4    :out std_logic_vector(9 downto 0) :=(others => '0')
    );
    end component;
begin
CL : Collatz port map(
    SysClk =>SysClk,
    Go => Go,
	 OutMX1 => OutMX1,
	 OutMX2 => OutMX2,
	 OutMX3 => OutMX3,
	 OutMX4 => OutMX4,
	 OutLEN1 => OutLEN1,
	 OutLEN2 => OutLEN2,
	 OutLEN3 => OutLEN3,
	 OutLEN4 => OutLEN4,
	 OutNAME1 => OutNAME1,
	 OutNAME2 => OutNAME2,
	 OutNAME3 => OutNAME3,
	 OutNAME4 => OutNAME4
    );
process begin
    SysClk <= '1';
    wait for 10 ns;
    SysClk <= '0';
    wait for 10 ns;
end process ;
process begin
    wait for 40 ns;
    Go <= '1';
    wait for 100000 ns;
    Go <= '0';
    wait for 5500 ns;
    end process;
end;
