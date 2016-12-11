
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name DSCable -dir "/home/michael/Xilinx/DSCable/planAhead_run_1" -part xc6slx4cpg196-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "TopLevel.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {ipcore_dir/video_buffer.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/scr_fifo.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/adc_buffer.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {VideoInterface.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {MCP3204_Interface.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/usb_buffer.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {UsbMuxer.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top UsbMuxer $srcset
add_files [list {TopLevel.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx4cpg196-3
