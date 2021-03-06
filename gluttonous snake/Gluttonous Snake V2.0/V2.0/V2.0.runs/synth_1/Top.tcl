# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35ticpg236-1L

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {G:/Gluttonous Snake/Gluttonous Snake V2.0/V2.0/V2.0.cache/wt} [current_project]
set_property parent.project_path {G:/Gluttonous Snake/Gluttonous Snake V2.0/V2.0/V2.0.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_cache_permissions disable [current_project]
read_verilog -library xil_defaultlib {
  {G:/Gluttonous Snake/Gluttonous Snake V2.0/codes/Display.v}
  {G:/Gluttonous Snake/Gluttonous Snake V2.0/codes/Snake_Control.v}
  {G:/Gluttonous Snake/Gluttonous Snake V2.0/codes/EatingApple.v}
  {G:/Gluttonous Snake/Gluttonous Snake V2.0/codes/vga_controller.v}
  {G:/Gluttonous Snake/Gluttonous Snake V2.0/codes/Clock_divide.v}
  {G:/Gluttonous Snake/Gluttonous Snake V2.0/codes/Button_Scan.v}
  {G:/Gluttonous Snake/Gluttonous Snake V2.0/codes/Game_Control.v}
  {G:/Gluttonous Snake/Gluttonous Snake V2.0/codes/Top.v}
}
read_xdc {{G:/Gluttonous Snake/Gluttonous Snake V2.0/V2.0/V2.0.srcs/constrs_2/new/Glu_Snake.xdc}}
set_property used_in_implementation false [get_files {{G:/Gluttonous Snake/Gluttonous Snake V2.0/V2.0/V2.0.srcs/constrs_2/new/Glu_Snake.xdc}}]

synth_design -top Top -part xc7a35ticpg236-1L
write_checkpoint -noxdef Top.dcp
catch { report_utilization -file Top_utilization_synth.rpt -pb Top_utilization_synth.pb }
