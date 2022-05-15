#Conf file for sta analysis post layout

#read_liberty timing_libs/sky130_fd_sc_hd__ff_100C_1v65.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ff_100C_1v95.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ff_n40C_1v65.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ff_n40C_1v76.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ff_n40C_1v95.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ff_n40C_1v56.lib

#read_liberty timing_libs/sky130_fd_sc_hd__tt_025C_1v80.lib

#read_liberty timing_libs/sky130_fd_sc_hd__ss_100C_1v40.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ss_100C_1v60.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ss_n40C_1v28.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ss_n40C_1v35.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ss_n40C_1v40.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ss_n40C_1v44.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ss_n40C_1v60.lib
#read_liberty timing_libs/sky130_fd_sc_hd__ss_n40C_1v76.lib

#read_verilog rvmyth.synthesis.v
#read_verilog rvmyth.synthesis_optimized.v
#read_verilog rvmyth.synthesis_cts.v
read_verilog rvmyth.synthesis_preroute.v
link_design rvmyth

#read_spef rvmyth.spef
#read_sdc rvmyth1.sdc
read_sdc -echo rvmyth.sdc


report_checks -path_delay max -fields {nets cap slew input_pins} > Post_synthesis/ff100C1v65_post_syn_max.rpt
report_checks -path_delay min -fields {nets cap slew input_pins} > Post_synthesis/ff100C1v65_post_syn_min.rpt

report_checks -path_delay min -fields {nets cap slew input_pins} -format full_clock_expanded -digits {4} > Clock_expanded/ff100C1v65_clock_min.rpt
report_checks -path_delay max -fields {nets cap slew input_pins} -format full_clock_expanded -digits {4} > Clock_expanded/ff100C1v65_max.rpt













