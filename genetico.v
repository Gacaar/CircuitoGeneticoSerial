module genetico(conf_les, conf_outs, chromIn, chromOut);

	input [26:0][14:0] conf_les;
	input [3:0][5:0] conf_outs;
	input [7:0] chromIn;
	output [3:0] chromOut;
	
	wire [26:0] le_out;
	wire [34:0] all_inputs;
	
	assign all_inputs = {le_out, chromIn};
	
	assign chromOut = {all_inputs[conf_outs[3]], all_inputs[conf_outs[2]], all_inputs[conf_outs[1]], all_inputs[conf_outs[0]]};
	
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

logic_e le50(
	.conf_func(conf_les[5][14:12]),
	.conf_ins(conf_les[5][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[5])
);

logic_e le60(
	.conf_func(conf_les[6][14:12]),
	.conf_ins(conf_les[6][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[6])
);

logic_e le70(
	.conf_func(conf_les[7][14:12]),
	.conf_ins(conf_les[7][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[7])
);

logic_e le80(
	.conf_func(conf_les[8][14:12]),
	.conf_ins(conf_les[8][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[8])
);

logic_e le90(
	.conf_func(conf_les[9][14:12]),
	.conf_ins(conf_les[9][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[9])
);

logic_e le100(
	.conf_func(conf_les[10][14:12]),
	.conf_ins(conf_les[10][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[10])
);

logic_e le110(
	.conf_func(conf_les[11][14:12]),
	.conf_ins(conf_les[11][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[11])
);

logic_e le120(
	.conf_func(conf_les[12][14:12]),
	.conf_ins(conf_les[12][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[12])
);

logic_e le130(
	.conf_func(conf_les[13][14:12]),
	.conf_ins(conf_les[13][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[13])
);

logic_e le140(
	.conf_func(conf_les[14][14:12]),
	.conf_ins(conf_les[14][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[14])
);

logic_e le150(
	.conf_func(conf_les[15][14:12]),
	.conf_ins(conf_les[15][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[15])
);

logic_e le160(
	.conf_func(conf_les[16][14:12]),
	.conf_ins(conf_les[16][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[16])
);

logic_e le170(
	.conf_func(conf_les[17][14:12]),
	.conf_ins(conf_les[17][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[17])
);

logic_e le180(
	.conf_func(conf_les[18][14:12]),
	.conf_ins(conf_les[18][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[18])
);

logic_e le190(
	.conf_func(conf_les[19][14:12]),
	.conf_ins(conf_les[19][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[19])
);

logic_e le200(
	.conf_func(conf_les[20][14:12]),
	.conf_ins(conf_les[20][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[20])
);

logic_e le210(
	.conf_func(conf_les[21][14:12]),
	.conf_ins(conf_les[21][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[21])
);

logic_e le220(
	.conf_func(conf_les[22][14:12]),
	.conf_ins(conf_les[22][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[22])
);

logic_e le230(
	.conf_func(conf_les[23][14:12]),
	.conf_ins(conf_les[23][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[23])
);

logic_e le240(
	.conf_func(conf_les[24][14:12]),
	.conf_ins(conf_les[24][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[24])
);

logic_e le250(
	.conf_func(conf_les[25][14:12]),
	.conf_ins(conf_les[25][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[25])
);

logic_e le260(
	.conf_func(conf_les[26][14:12]),
	.conf_ins(conf_les[26][11:0]),
	.all_inputs(all_inputs),
	.leOut(le_out[26])
);


endmodule
