library IEEE;
use IEEE.std_logic_1164.all;

entity twi_io_buffer is
  port (
    twi_sda_o : in  std_ulogic;
    twi_scl_o : in  std_ulogic;

    sda_io    : inout std_ulogic;
    scl_io    : inout std_ulogic;

    twi_sda_i : out std_ulogic;
    twi_scl_i : out std_ulogic
  );
end entity twi_io_buffer;

architecture Behavioral of twi_io_buffer is
begin
  sda_io <= '0' when (twi_sda_o = '0') else 'Z';
  scl_io <= '0' when (twi_scl_o = '0') else 'Z';

  twi_sda_i <= sda_io;
  twi_scl_i <= scl_io;
end architecture Behavioral;