#conf file for openSTA


#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ff_100C_1v65.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ff_100C_1v95.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ff_n40C_1v65.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ff_n40C_1v76.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ff_n40C_1v95.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ff_n40C_1v56.lib

read_liberty ../../timing_libs/sky130_fd_sc_hd__tt_025C_1v80.lib

#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ss_100C_1v40.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ss_100C_1v60.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v28.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v35.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v40.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v44.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v60.lib
#read_liberty  ../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v76.lib
read_verilog yosys_out/SD.synth.v
link_design my_module
read_sdc SD.sdc
report_checks -path_delay min_max -fields {nets cap slew input_pins} -digits {4} > sta_out/tt025C1v80_SD.rpt
report_worst_slack -max > sta_out/tt025C1v80_SD_max.rpt
report_worst_slack -min > sta_out/tt025C1v80_SD_min.rpt
report_tns > sta_out/tt025C1v80_SD_tns.rpt





