read_liberty timing_libs/sky130_fd_sc_hd__ss_n40C_1v76.lib
read_verilog netlist.v
link_design my_module
create_clock -period 1 -name clk {clk}
report_checks -fields {nets cap slew input_pins} -digits {4}
report_checks -path_delay min -fields {nets cap slew input_pins} -digits {4}





