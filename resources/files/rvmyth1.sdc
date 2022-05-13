set_units -time ns
create_clock [get_ports clk]  -name clk  -period 10
set_propagated_clock [all_clocks]
