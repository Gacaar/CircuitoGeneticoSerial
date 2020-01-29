module genetico(conf_les, conf_outs, chromIn, chromOut);

	input [24:0][14:0] conf_les;
	input [7:0][5:0] conf_outs;
	input [7:0] chromIn;
	output [7:0] chromOut;
	
	wire [24:0] le_out;
	wire [32:0] all_inputs;
	
	assign all_inputs = {le_out, chromIn};
	
	assign chromOut = {all_inputs[conf_outs[7]], all_inputs[conf_outs[6]], all_inputs[conf_outs[5]], all_inputs[conf_outs[4]], all_inputs[conf_outs[3]], all_inputs[conf_outs[2]], all_inputs[conf_outs[1]], all_inputs[conf_outs[0]]};
	
logic_e le00(
	.conf_func(conf_les[0][14:12]),
	.conf_ins(conf_les[0][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[0])
);

logic_e le10(
	.conf_func(conf_les[1][14:12]),
	.conf_ins(conf_les[1][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[1])
);

logic_e le20(
	.conf_func(conf_les[2][14:12]),
	.conf_ins(conf_les[2][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[2])
);

logic_e le30(
	.conf_func(conf_les[3][14:12]),
	.conf_ins(conf_les[3][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[3])
);

logic_e le40(
	.conf_func(conf_les[4][14:12]),
	.conf_ins(conf_les[4][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[4])
);

logic_e le01(
	.conf_func(conf_les[5][14:12]),
	.conf_ins(conf_les[5][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[5])
);

logic_e le11(
	.conf_func(conf_les[6][14:12]),
	.conf_ins(conf_les[6][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[6])
);

logic_e le21(
	.conf_func(conf_les[7][14:12]),
	.conf_ins(conf_les[7][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[7])
);

logic_e le31(
	.conf_func(conf_les[8][14:12]),
	.conf_ins(conf_les[8][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[8])
);

logic_e le41(
	.conf_func(conf_les[9][14:12]),
	.conf_ins(conf_les[9][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[9])
);

logic_e le02(
	.conf_func(conf_les[10][14:12]),
	.conf_ins(conf_les[10][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[10])
);

logic_e le12(
	.conf_func(conf_les[11][14:12]),
	.conf_ins(conf_les[11][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[11])
);

logic_e le22(
	.conf_func(conf_les[12][14:12]),
	.conf_ins(conf_les[12][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[12])
);

logic_e le32(
	.conf_func(conf_les[13][14:12]),
	.conf_ins(conf_les[13][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[13])
);

logic_e le42(
	.conf_func(conf_les[14][14:12]),
	.conf_ins(conf_les[14][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[14])
);

logic_e le03(
	.conf_func(conf_les[15][14:12]),
	.conf_ins(conf_les[15][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[15])
);

logic_e le13(
	.conf_func(conf_les[16][14:12]),
	.conf_ins(conf_les[16][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[16])
);

logic_e le23(
	.conf_func(conf_les[17][14:12]),
	.conf_ins(conf_les[17][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[17])
);

logic_e le33(
	.conf_func(conf_les[18][14:12]),
	.conf_ins(conf_les[18][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[18])
);

logic_e le43(
	.conf_func(conf_les[19][14:12]),
	.conf_ins(conf_les[19][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[19])
);

logic_e le04(
	.conf_func(conf_les[20][14:12]),
	.conf_ins(conf_les[20][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[20])
);

logic_e le14(
	.conf_func(conf_les[21][14:12]),
	.conf_ins(conf_les[21][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[21])
);

logic_e le24(
	.conf_func(conf_les[22][14:12]),
	.conf_ins(conf_les[22][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[22])
);

logic_e le34(
	.conf_func(conf_les[23][14:12]),
	.conf_ins(conf_les[23][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[23])
);

logic_e le44(
	.conf_func(conf_les[24][14:12]),
	.conf_ins(conf_les[24][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[24])
);


endmodule
