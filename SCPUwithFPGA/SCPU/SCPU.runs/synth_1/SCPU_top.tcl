# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.cache/wt [current_project]
set_property parent.project_path E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo e:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/Register.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/PC.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/Mux_signExtend.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/Mux_RegDst.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/Mux_PCSrc.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/Mux_display.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/Mux_ALU_memory_to_reg.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/Mux_ALUSrc.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/instructionMemory.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/DataMemory.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/control_unit.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/ALU.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/addr_shift.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/seg7.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/SCPU.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/artificial_impulse.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/clk_div.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/Button_Scaning.v
  E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/sources_1/new/SCPU_top.v
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/constrs_1/new/SCPU.xdc
set_property used_in_implementation false [get_files E:/vivado_homework/SCPUwithFPGA/SCPU/SCPU.srcs/constrs_1/new/SCPU.xdc]


synth_design -top SCPU_top -part xc7a35tcpg236-1


write_checkpoint -force -noxdef SCPU_top.dcp

catch { report_utilization -file SCPU_top_utilization_synth.rpt -pb SCPU_top_utilization_synth.pb }
