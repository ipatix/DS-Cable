
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name DSCable -dir "/home/michael/Xilinx/DSCable/planAhead_run_2" -part xc6slx4cpg196-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/home/michael/Xilinx/DSCable/UsbMuxer.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/michael/Xilinx/DSCable} {ipcore_dir} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "TopLevel.ucf" [current_fileset -constrset]
add_files [list {TopLevel.ucf}] -fileset [get_property constrset [current_run]]
link_design
