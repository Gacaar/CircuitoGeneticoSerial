module fenotipo(
    input [422:0] cromossomo,
    input [7:0] chromIn,
    output wire [7:0] chromOut
);

    wire [24:0][14:0] descricao_les;
    wire [7:0][5:0] descricao_outs;
    
	assign descricao_les[0] = cromossomo[14:0];
	assign descricao_les[1] = cromossomo[29:15];
	assign descricao_les[2] = cromossomo[44:30];
	assign descricao_les[3] = cromossomo[59:45];
	assign descricao_les[4] = cromossomo[74:60];
	assign descricao_les[5] = cromossomo[89:75];
	assign descricao_les[6] = cromossomo[104:90];
	assign descricao_les[7] = cromossomo[119:105];
	assign descricao_les[8] = cromossomo[134:120];
	assign descricao_les[9] = cromossomo[149:135];
	assign descricao_les[10] = cromossomo[164:150];
	assign descricao_les[11] = cromossomo[179:165];
	assign descricao_les[12] = cromossomo[194:180];
	assign descricao_les[13] = cromossomo[209:195];
	assign descricao_les[14] = cromossomo[224:210];
	assign descricao_les[15] = cromossomo[239:225];
	assign descricao_les[16] = cromossomo[254:240];
	assign descricao_les[17] = cromossomo[269:255];
	assign descricao_les[18] = cromossomo[284:270];
	assign descricao_les[19] = cromossomo[299:285];
	assign descricao_les[20] = cromossomo[314:300];
	assign descricao_les[21] = cromossomo[329:315];
	assign descricao_les[22] = cromossomo[344:330];
	assign descricao_les[23] = cromossomo[359:345];
	assign descricao_les[24] = cromossomo[374:360];

	assign descricao_outs[0] = cromossomo[380:375];
	assign descricao_outs[1] = cromossomo[386:381];
	assign descricao_outs[2] = cromossomo[392:387];
	assign descricao_outs[3] = cromossomo[398:393];
	assign descricao_outs[4] = cromossomo[404:399];
	assign descricao_outs[5] = cromossomo[410:405];
	assign descricao_outs[6] = cromossomo[416:411];
	assign descricao_outs[7] = cromossomo[422:417];

genetico genetico(
    .conf_les(descricao_les),
    .conf_outs(descricao_outs),
    .chromIn(chromIn),
    .chromOut(chromOut)
);

endmodule
