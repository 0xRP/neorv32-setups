set part "xc7a100tcsg324-1"
set prj "nexys4ddr-pr7"

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

# add source files: core sources
# add_files [glob ./../../neorv32/rtl/core/*.vhd]
# set_property library neorv32 [get_files [glob ./../../neorv32/rtl/core/*.vhd]]

# add source file: top entity
# add_files [glob ./../../neorv32/rtl/test_setups/neorv32_test_setup_bootloader.vhd]

# add source files: simulation-only
# add_files -fileset sim_1 [list ./../../neorv32/sim/neorv32_tb.vhd ./../../neorv32/sim/sim_uart_rx.vhd]

# add source files: constraints
add_files -fileset constrs_1 [glob ./*.xdc]

# add IP
set_property IP_REPO_PATHS {../../neorv32/rtl/system_integration/neorv32_vivado_ip_work/packaged_ip/} [current_fileset]

# run synthesis, implementation and bitstream generation
# launch_runs impl_1 -to_step write_bitstream -jobs 4
# wait_on_run impl_1
