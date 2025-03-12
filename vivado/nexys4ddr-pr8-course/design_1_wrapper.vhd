library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity design_1_wrapper is
  port (
    clk_i      : in  STD_LOGIC;
    rst_i      : in  STD_LOGIC;
    uart0_rxd_i: in  STD_LOGIC;
    uart0_txd_o: out STD_LOGIC;

    sda_io     : inout STD_LOGIC;
    scl_io     : inout STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is

  component design_1 is
    port (
      clk_i      : in  STD_LOGIC;
      rst_i      : in  STD_LOGIC;
      uart0_txd_o: out STD_LOGIC;
      uart0_rxd_i: in  STD_LOGIC;
      twi_sda_o  : out STD_LOGIC;
      twi_scl_o  : out STD_LOGIC;
      twi_sda_i  : in  STD_LOGIC;
      twi_scl_i  : in  STD_LOGIC
    );
  end component;

  component twi_io_buffer is
    port (
      twi_sda_o : in  STD_LOGIC;
      twi_scl_o : in  STD_LOGIC;
      sda_io    : inout STD_LOGIC;
      scl_io    : inout STD_LOGIC;
      twi_sda_i : out STD_LOGIC;
      twi_scl_i : out STD_LOGIC
    );
  end component;

  signal int_twi_sda_o, int_twi_scl_o : STD_LOGIC;
  signal int_twi_sda_i, int_twi_scl_i : STD_LOGIC;

begin

  design_1_i: design_1
    port map (
      clk_i       => clk_i,
      rst_i       => rst_i,
      uart0_rxd_i => uart0_rxd_i,
      uart0_txd_o => uart0_txd_o,
      twi_sda_o   => int_twi_sda_o,
      twi_scl_o   => int_twi_scl_o,
      twi_sda_i   => int_twi_sda_i,
      twi_scl_i   => int_twi_scl_i
    );

  i2c_buffer_inst: twi_io_buffer
    port map (
      twi_sda_o => int_twi_sda_o,
      twi_scl_o => int_twi_scl_o,
      sda_io    => sda_io,
      scl_io    => scl_io,
      twi_sda_i => int_twi_sda_i,
      twi_scl_i => int_twi_scl_i
    );

end STRUCTURE;
