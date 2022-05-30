module my_module (
in,
clk,
out
);

// primary inputs
input in;
input clk;

// primary outputs
output out;

// wires
wire n1;
wire n2;
wire n3;
wire n4;
wire n5;
wire n6;
wire in;
wire clk;
wire out;

// cells
sky130_fd_sc_hd__dfxtp_4 f1 (.D(in), .CLK(clk), .Q(n1));
sky130_fd_sc_hd__inv_1 u3 (.A(n1), .Y(n2));
sky130_fd_sc_hd__inv_1 u4 (.A(n2), .Y(n3));
sky130_fd_sc_hd__nand2_1 u6 ( .A(n1), .B(n3), .Y(n4));
sky130_fd_sc_hd__nand2_2 u5 ( .A(n3), .B(n2), .Y(n5));
sky130_fd_sc_hd__nor2_1 u7 ( .A(n4), .B(n5), .Y(n6));
sky130_fd_sc_hd__dfxtp_4 f2 ( .D(n6), .CLK(clk), .Q(out));

endmodule
