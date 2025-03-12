set part "xc7a100tcsg324-1"
set prj "nexys4ddr-pr8"

# create and clear output directory
set outputdir work
file mkdir $outputdir

set files [glob -nocomplain "$outputdir/*"]
if {[llength $files] != 0} {
    puts "deleting contents of $outputdir"
    file delete -force {*}[glob -directory $outputdir *]; # clear folder contents
} else {
    puts "$outputdir is empty"
}

# create project
create_project -part $part $prj $outputdir

# add source files: constraints
add_files -fileset constrs_1 [glob ./*.xdc]

# add IP
set_property IP_REPO_PATHS {../../neorv32/rtl/system_integration/neorv32_vivado_ip_work/packaged_ip/} [current_fileset]

# set VHDL
set_property target_language VHDL [current_project]

#### create block design
create_bd_design "design_1"
update_compile_order -fileset sources_1

# add neorv32
startgroup
create_bd_cell -type ip -vlnv NEORV32:user:neorv32_vivado_ip:1.0 neorv32_vivado_ip_0
endgroup

# configure neorv32
set_property -dict [list \
  CONFIG.IO_TWI_EN {true} \
  CONFIG.IO_UART0_EN {true} \
  CONFIG.MEM_INT_DMEM_EN {true} \
  CONFIG.MEM_INT_IMEM_EN {true} \
] [get_bd_cells neorv32_vivado_ip_0]

# add clocking wizard
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
endgroup

# clocking wizard pins
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Clk {New External Port} Manual_Source {Auto}}  [get_bd_pins clk_wiz_0/clk_in1]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {New External Port (ACTIVE_HIGH)}}  [get_bd_pins clk_wiz_0/reset]
endgroup
set_property name rst_i [get_bd_ports reset_rtl_0]
set_property name clk_i [get_bd_ports clk_100MHz]
connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins neorv32_vivado_ip_0/clk]
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins neorv32_vivado_ip_0/resetn]

# make uart external, set pin names
startgroup
make_bd_pins_external  [get_bd_pins neorv32_vivado_ip_0/uart0_txd_o]
endgroup
set_property name uart0_txd_o [get_bd_ports uart0_txd_o_0]
startgroup
make_bd_pins_external  [get_bd_pins neorv32_vivado_ip_0/uart0_rxd_i]
endgroup
set_property name uart0_rxd_i [get_bd_ports uart0_rxd_i_0]

# add io buffer
import_files -norecurse ./twi_io_buffer.vhd
update_compile_order -fileset sources_1

# add io buffer to bd
#create_bd_cell -type module -reference twi_io_buffer twi_io_buffer_0
#
## io buffer connections
#connect_bd_net [get_bd_pins twi_io_buffer_0/twi_sda_o] [get_bd_pins neorv32_vivado_ip_0/twi_sda_o]
#connect_bd_net [get_bd_pins twi_io_buffer_0/twi_scl_o] [get_bd_pins neorv32_vivado_ip_0/twi_scl_o]
#connect_bd_net [get_bd_pins twi_io_buffer_0/twi_sda_i] [get_bd_pins neorv32_vivado_ip_0/twi_sda_i]
#connect_bd_net [get_bd_pins twi_io_buffer_0/twi_scl_i] [get_bd_pins neorv32_vivado_ip_0/twi_scl_i]
#
## make external
#startgroup
#make_bd_pins_external  [get_bd_pins twi_io_buffer_0/sda_io]
#endgroup
#startgroup
#make_bd_pins_external  [get_bd_pins twi_io_buffer_0/scl_io]
#endgroup
#
## set name
#set_property name sda_io [get_bd_ports sda_io_0]
#set_property name scl_io [get_bd_ports scl_io_0]

# make TWI pins external
startgroup
make_bd_pins_external  [get_bd_pins neorv32_vivado_ip_0/twi_sda_o]
endgroup
startgroup
make_bd_pins_external  [get_bd_pins neorv32_vivado_ip_0/twi_scl_o]
endgroup
startgroup
make_bd_pins_external  [get_bd_pins neorv32_vivado_ip_0/twi_sda_i]
endgroup
startgroup
make_bd_pins_external  [get_bd_pins neorv32_vivado_ip_0/twi_scl_i]
endgroup

# set correct names
set_property name twi_sda_o [get_bd_ports twi_sda_o_0]
set_property name twi_scl_o [get_bd_ports twi_scl_o_0]
set_property name twi_sda_i [get_bd_ports twi_sda_i_0]
set_property name twi_scl_i [get_bd_ports twi_scl_i_0]

#make_wrapper -files [get_files ./work/nexys4ddr-pr8.srcs/sources_1/bd/design_1/design_1.bd] -top
import_files -force -norecurse ./design_1_wrapper.vhd

# run synthesis, implementation and bitstream generation
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
