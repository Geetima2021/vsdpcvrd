
#read_liberty ../../../timing_libs/sky130_fd_sc_hd__ff_100C_1v65.lib
#read_liberty ../../../timing_libs/sky130_fd_sc_hd__ff_100C_1v95.lib
#read_liberty ../../../timing_libs/sky130_fd_sc_hd__ff_n40C_1v65.lib
#read_liberty ../../../timing_libs/sky130_fd_sc_hd__ff_n40C_1v76.lib
#read_liberty ../../../timing_libs/sky130_fd_sc_hd__ff_n40C_1v95.lib
#read_liberty ../../../timing_libs/sky130_fd_sc_hd__ff_n40C_1v56.lib

read_liberty ../../../timing_libs/sky130_fd_sc_hd__tt_025C_1v80.lib

#read_liberty  ../../../timing_libs/sky130_fd_sc_hd__ss_100C_1v40.lib
#read_liberty  ../../../timing_libs/sky130_fd_sc_hd__ss_100C_1v60.lib
#read_liberty ../../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v28.lib
#read_liberty ../../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v35.lib
#read_liberty  ../../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v40.lib
#read_liberty  ../../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v44.lib
#read_liberty ../../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v60.lib
#read_liberty  ../../../timing_libs/sky130_fd_sc_hd__ss_n40C_1v76.lib

read_verilog ../output/sky130_fd_sc_hd__tt_025C_1v80.synth.v

link_design core
create_clock -period 10 -name clk {clk}

report_checks -path_delay min_max -fields {nets cap slew input_pins} -digits 4 > ../output/opensta_10ns/tt025C1v28_min_max.rpt
report_worst_slack -max > ../output/worst_tns_10ns/tt025C1v28_max.rpt
report_worst_slack -min > ../output/worst_tns_10ns/tt025C1v28_min.rpt
report_tns > ../output/worst_tns_10ns/tt025C1v28_tns.rpt



