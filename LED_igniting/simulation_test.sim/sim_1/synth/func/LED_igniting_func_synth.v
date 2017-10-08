// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.3 (win64) Build 1682563 Mon Oct 10 19:07:27 MDT 2016
// Date        : Tue May 16 19:26:10 2017
// Host        : YR151215-IXCK running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               E:/vivado_homework/LED_igniting/simulation_test.sim/sim_1/synth/func/LED_igniting_func_synth.v
// Design      : LED_igniting
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35ticpg236-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* NotValidForBitStream *)
module LED_igniting
   (L0,
    L1,
    L2,
    L3,
    L4,
    L5,
    L6,
    L7,
    L8,
    L9,
    L10,
    L11,
    L12,
    L13,
    L14,
    L15);
  output L0;
  output L1;
  output L2;
  output L3;
  output L4;
  output L5;
  output L6;
  output L7;
  output L8;
  output L9;
  output L10;
  output L11;
  output L12;
  output L13;
  output L14;
  output L15;

  wire L0;
  wire L1;
  wire L10;
  wire L10_OBUF;
  wire L11;
  wire L11_OBUF;
  wire L12;
  wire L12_OBUF;
  wire L13;
  wire L13_OBUF;
  wire L14;
  wire L14_OBUF;
  wire L15;
  wire L15_OBUF;
  wire L2;
  wire L3;
  wire L4;
  wire L5;
  wire L6;
  wire L7;
  wire L8;
  wire L8_OBUF;
  wire L9;
  wire L9_OBUF;
  wire clk;
  wire direction;
  wire direction_i_1_n_0;
  wire [2:0]s;
  wire \s[0]_i_1_n_0 ;
  wire \s[1]_i_1_n_0 ;
  wire \s[2]_i_1_n_0 ;

  OBUF L0_OBUF_inst
       (.I(L15_OBUF),
        .O(L0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h01)) 
    L0_OBUF_inst_i_1
       (.I0(s[2]),
        .I1(s[0]),
        .I2(s[1]),
        .O(L15_OBUF));
  OBUF L10_OBUF_inst
       (.I(L10_OBUF),
        .O(L10));
  OBUF L11_OBUF_inst
       (.I(L11_OBUF),
        .O(L11));
  OBUF L12_OBUF_inst
       (.I(L12_OBUF),
        .O(L12));
  OBUF L13_OBUF_inst
       (.I(L13_OBUF),
        .O(L13));
  OBUF L14_OBUF_inst
       (.I(L14_OBUF),
        .O(L14));
  OBUF L15_OBUF_inst
       (.I(L15_OBUF),
        .O(L15));
  OBUF L1_OBUF_inst
       (.I(L14_OBUF),
        .O(L1));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h04)) 
    L1_OBUF_inst_i_1
       (.I0(s[2]),
        .I1(s[0]),
        .I2(s[1]),
        .O(L14_OBUF));
  OBUF L2_OBUF_inst
       (.I(L13_OBUF),
        .O(L2));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h04)) 
    L2_OBUF_inst_i_1
       (.I0(s[0]),
        .I1(s[1]),
        .I2(s[2]),
        .O(L13_OBUF));
  OBUF L3_OBUF_inst
       (.I(L12_OBUF),
        .O(L3));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h08)) 
    L3_OBUF_inst_i_1
       (.I0(s[1]),
        .I1(s[0]),
        .I2(s[2]),
        .O(L12_OBUF));
  OBUF L4_OBUF_inst
       (.I(L11_OBUF),
        .O(L4));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h04)) 
    L4_OBUF_inst_i_1
       (.I0(s[0]),
        .I1(s[2]),
        .I2(s[1]),
        .O(L11_OBUF));
  OBUF L5_OBUF_inst
       (.I(L10_OBUF),
        .O(L5));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h08)) 
    L5_OBUF_inst_i_1
       (.I0(s[2]),
        .I1(s[0]),
        .I2(s[1]),
        .O(L10_OBUF));
  OBUF L6_OBUF_inst
       (.I(L9_OBUF),
        .O(L6));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h08)) 
    L6_OBUF_inst_i_1
       (.I0(s[1]),
        .I1(s[2]),
        .I2(s[0]),
        .O(L9_OBUF));
  OBUF L7_OBUF_inst
       (.I(L8_OBUF),
        .O(L7));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h80)) 
    L7_OBUF_inst_i_1
       (.I0(s[1]),
        .I1(s[2]),
        .I2(s[0]),
        .O(L8_OBUF));
  OBUF L8_OBUF_inst
       (.I(L8_OBUF),
        .O(L8));
  OBUF L9_OBUF_inst
       (.I(L9_OBUF),
        .O(L9));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hFE80)) 
    direction_i_1
       (.I0(s[1]),
        .I1(s[2]),
        .I2(s[0]),
        .I3(direction),
        .O(direction_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    direction_reg
       (.C(clk),
        .CE(1'b1),
        .D(direction_i_1_n_0),
        .Q(direction),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h40FD)) 
    \s[0]_i_1 
       (.I0(direction),
        .I1(s[2]),
        .I2(s[1]),
        .I3(s[0]),
        .O(\s[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hAD4A)) 
    \s[1]_i_1 
       (.I0(s[1]),
        .I1(s[2]),
        .I2(direction),
        .I3(s[0]),
        .O(\s[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hCE8C)) 
    \s[2]_i_1 
       (.I0(s[1]),
        .I1(s[2]),
        .I2(direction),
        .I3(s[0]),
        .O(\s[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \s_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\s[0]_i_1_n_0 ),
        .Q(s[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\s[1]_i_1_n_0 ),
        .Q(s[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \s_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\s[2]_i_1_n_0 ),
        .Q(s[2]),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \s_reg[2]_i_2 
       (.I0(clk),
        .O(clk));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
