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

# set target lang 
set_property target_language VHDL [current_project]

# add source files: constraints
add_files -fileset constrs_1 [glob ./*.xdc]
