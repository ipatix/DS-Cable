
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name DSCable -dir "/home/michael/Xilinx/DSCable/planAhead_run_4" -part xc6slx4cpg196-3
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "/home/michael/Xilinx/DSCable/TopLevel.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/michael/Xilinx/DSCable} }
set_property target_constrs_file "TopLevel.ucf" [current_fileset -constrset]
add_files [list {TopLevel.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "/home/michael/Xilinx/DSCable/TopLevel.ncd"
if {[catch {read_twx -name results_1 -file "/home/michael/Xilinx/DSCable/TopLevel.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"/home/michael/Xilinx/DSCable/TopLevel.twx\": $eInfo"
}
