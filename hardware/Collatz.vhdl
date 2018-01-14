	library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
entity Collatz is
port(
    SysClk  :in std_logic:='0';
	 Go :in std_logic := '0';
	 OutCNT :out std_logic_vector(7 downto 0) :=(others => '0') ;
	 OutINDEX     :out std_logic_vector(9 downto 0) :=(others => '0') ;
	 OutDATA     :out std_logic_vector(17 downto 0) :=(others => '0') ;
    OutMX     :out std_logic_vector(17 downto 0) :=(others => '0') ;

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
end Collatz;
architecture RTL of Collatz is
	 signal done : std_logic := '0';
    signal data     :std_logic_vector(17 downto 0) :=(others => '0') ;
    signal index     :std_logic_vector(9 downto 0) :=(others => '0') ;
    signal mx     :std_logic_vector(17 downto 0) :=(others => '0') ;
    signal cnt     :std_logic_vector(7 downto 0) :=(others => '0') ;
	 type T_TRACE is array(0 to 2048) of std_logic_vector(9 downto 0);
	 signal TRACE : T_TRACE := (others => (others => '0'));
	 type T_MEMMX is array(0 to 2048) of std_logic_vector(17 downto 0);
	 signal MEMMX : T_MEMMX := (others => (others => '0'));
	 type T_MEMLEN is array(0 to 2048) of std_logic_vector(7 downto 0);
	 signal MEMLEN : T_MEMLEN := (others => (others => '0'));
	 
	 signal mx1     :std_logic_vector(17 downto 0):=(others => '0');
	 signal mx2     :std_logic_vector(17 downto 0):=(others => '0');
	 signal mx3     :std_logic_vector(17 downto 0):=(others => '0');
	 signal mx4     :std_logic_vector(17 downto 0):=(others => '0');
	 signal len1    :std_logic_vector(7 downto 0) :=(others => '0');
	 signal len2    :std_logic_vector(7 downto 0) :=(others => '0');
	 signal len3    :std_logic_vector(7 downto 0) :=(others => '0');
	 signal len4    :std_logic_vector(7 downto 0) :=(others => '0');
	 signal name1    :std_logic_vector(9 downto 0) :=(others => '0');
	 signal name2    :std_logic_vector(9 downto 0) :=(others => '0');
	 signal name3    :std_logic_vector(9 downto 0) :=(others => '0');
	 signal name4    :std_logic_vector(9 downto 0) :=(others => '0');
begin

    process begin
    wait until rising_edge(SysClk);
	     if Go='0' then
			data  <= "000000000000000001";
			index <= "0000000001";
			mx    <= "000000000000000000";
			cnt   <= "00000000";
		  elsif done='1' then
		  -- pass
		  else
		  	  if data < "0000100000000000" and MEMMX(conv_integer(data))="000000000000000000" then
					MEMMX(conv_integer(data)) <= mx;
					MEMLEN(conv_integer(data)) <= cnt;
					TRACE(conv_integer(data)) <= index;
			  end if;

		     if data="000000000000000001" then
				   if index = "1111111111" then
					 done <= '1';
					end if;
					MEMMX(conv_integer(index)) <= mx;
					MEMLEN(conv_integer(index)) <= cnt;
					TRACE(conv_integer(index)) <= "0000000000";
					index <= index + 2;
					data <= "00000000" & (index + 2);
					mx <= "000000000000000000";
					cnt   <= "00000000";
					if mx1 = mx then
					  if len1 < cnt then
					   len1 <= cnt;
						name1 <= index;
					  end if;
				   elsif mx2 = mx then
					 if len2 < cnt then
					   len2 <= cnt;
						name2 <= index;
					 end if;

				   elsif mx3 = mx then
					 if len3 < cnt then
					   len3 <= cnt;
						name3 <= index;
					 end if;
				   elsif mx4 = mx then
					 if len4 < cnt then
					   len4 <= cnt;
						name4 <= index;
					 end if;
					elsif mx1 < mx then
					 mx4 <= mx3;
					 mx3 <= mx2;
					 mx2 <= mx1;
					 len4 <= len3;
					 len3 <= len2;
					 len2 <= len1;
					 name4 <= name3;
					 name3 <= name2;
					 name2 <= name1;
					 mx1 <= mx;
					 len1 <= cnt;
					 name1 <= index;
					elsif mx2 < mx then
					 mx4 <= mx3;
					 mx3 <= mx2;
					 len4 <= len3;
					 len3 <= len2;
					 name4 <= name3;
					 name3 <= name2;
					 mx2 <= mx;
					 len2 <= cnt;
					 name2 <= index;
					elsif mx3 < mx then
					 mx4 <= mx3;
					 len4 <= len3;
					 name4 <= name3;
					 mx3 <= mx;
					 len3 <= cnt;
					 name3 <= index;
					elsif mx4 < mx then
					 mx4 <= mx;
					 len4 <= cnt;
					 name4 <= index;
					end if;
			  else
					if data > "0000011111111111" or MEMMX(conv_integer(data)) = "000000000000000000" then
					--if data=data then
						if data="000000000000000010" then 
						  cnt <= cnt + 1;
						  data <= "000000000000000001";
						elsif data(1 downto 0) = "00" then
							cnt <= cnt + 2;
							data <= "00" & data(17 downto 2);
						elsif data(1 downto 0) = "01" then
						  if mx < (data + (data(16 downto 0) & '1')) then
							 mx <= data + (data(16 downto 0) & '1');
						  end if;
							cnt <= cnt + 3;
							data <= ('0' & data(17 downto 2) & '1') + ("00" & data(17 downto 2));
						elsif data(1 downto 0) = "10" then
						  if mx < ( ('0' & data(17 downto 1)) + (data(17 downto 1) & '1')) then
							 mx <= ('0' & data(17 downto 1)) + (data(17 downto 1) & '1');
						  end if;
							cnt <= cnt + 3;
							data <= ('0' & data(17 downto 2) & '0') + ("00" & data(17 downto 2)) + "0000000000000010";
						elsif data(1 downto 0) = "11" then
							if mx < ((data(15 downto 2) & "0000") + ('0' & data(17 downto 2) &'0') + "0000000000010000")
							then 
								mx <= ((data(15 downto 2) & "0000") + ('0' & data(17 downto 2) &'0') + "0000000000010000");
							end if;
							cnt <= cnt + 4;
							data <= (data(16 downto 2) & "000") + ("00" & data(17 downto 2)) + "0000000000001000";
						end if;
					else
						if TRACE(conv_integer(data)) = "0000000000" then
							if mx < MEMMX(conv_integer(data)) then
								mx <= MEMMX(conv_integer(data));
							end if;
							cnt <= cnt + MEMLEN(conv_integer(data));
							data <= "000000000000000001";
						else
							if MEMMX(conv_integer(data)) < MEMMX(conv_integer(TRACE(conv_integer(data)))) then
								if mx < MEMMX(conv_integer(TRACE(conv_integer(data)))) then
									mx <=MEMMX(conv_integer(TRACE(conv_integer(data))));
								end if;
								cnt <= cnt + (MEMLEN(conv_integer(TRACE(conv_integer(data)))) - MEMLEN(conv_integer(data)));
								data <= "000000000000000001";
							elsif mx >= MEMMX(conv_integer(data)) then
								cnt <= cnt + (MEMLEN(conv_integer(TRACE(conv_integer(data)))) - MEMLEN(conv_integer(data)));
								data <= "000000000000000001";
							else
								if data="000000000000000010" then 
									cnt <= cnt + 1;
									data <= "000000000000000001";
								elsif data(1 downto 0) = "00" then
									cnt <= cnt + 2;
									data <= "00" & data(17 downto 2);
								elsif data(1 downto 0) = "01" then
									if mx < (data + (data(16 downto 0) & '1')) then
										mx <= data + (data(16 downto 0) & '1');
									end if;
									cnt <= cnt + 3;
									data <= ('0' & data(17 downto 2) & '1') + ("00" & data(17 downto 2));
								elsif data(1 downto 0) = "10" then
									if mx < ( ('0' & data(17 downto 1)) + (data(17 downto 1) & '1')) then
										mx <= ('0' & data(17 downto 1)) + (data(17 downto 1) & '1');
									end if;
									cnt <= cnt + 3;
									data <= ('0' & data(17 downto 2) & '0') + ("00" & data(17 downto 2)) + "0000000000000010";
								elsif data(1 downto 0) = "11" then
									if mx < ((data(15 downto 2) & "0000") + ('0' & data(17 downto 2) &'0') + "0000000000010000")
									then 
										mx <= ((data(15 downto 2) & "0000") + ('0' & data(17 downto 2) &'0') + "0000000000010000");
									end if;
									cnt <= cnt + 4;
									data <= (data(16 downto 2) & "000") + ("00" & data(17 downto 2)) + "0000000000001000";
								end if;
							end if;
						end if;
					end if;
			  end if;
		  end if;
	end process;
		  OutMX <= mx;
		  OutCNT <= cnt;
		  OutINDEX <= index;
		  OutDATA <= data;
		  OutMX1 <= mx1;
		  OutMX2 <= mx2;
		  OutMX3 <= mx3;
		  OutMX4 <= mx4;
		  OutLEN1 <= len1;
		  OutLEN2 <= len2;
		  OutLEN3 <= len3;
		  OutLEN4 <= len4;
		  OutNAME1 <= name1;
		  OutNAME2 <= name2;
		  OutNAME3 <= name3;
		  OutNAME4 <= name4;
end RTL;

