read_liberty sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog netlist.v
link_design my_module
read_sdf my_module.sdf
create_clock -period 1 -name clk {clk}




