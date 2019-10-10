module newGenetico(saidas_LE, out_chrom, inp, out);

	input wire [3:0][3:0][15:0] saidas_LE; 	// Tabela verdade (saidas) de cada elemento
	input wire [3:0] out_chrom; 		// Seletor do mux de saida
	input wire [3:0] inp; 				// Entradas do circuito
	output wire [0:0] out;				// Saidas do circuito
	
	wire [3:0][3:0]LE_out;				// Saida de cada elemento



//--------------------------------------BORDA SUPERIOR-------------------------------------------------------	
newlogic_e le00( //NOVO LOGIC_E ???
	.saidas(saidas_LE[0][0]),
	.inp({1'b0, LE_out[0][1], LE_out[1][0], inp[0]}),
	.out(LE_out[0][0])
);

newlogic_e le01(
	.saidas(saidas_LE[0][1]),
	.inp({1'b0, LE_out[0][2], LE_out[1][1], LE_out[0][0]}),
	.out(LE_out[0][1])
);

newlogic_e le02(
	.saidas(saidas_LE[0][2]),
	.inp({1'b0, LE_out[0][3], LE_out[1][2], LE_out[0][1]}),
	.out(LE_out[0][2])
);

newlogic_e le03(				//------------------------CANTO ESQUERDO
	.saidas(saidas_LE[0][3]),
	.inp({1'b0, 1'b0, LE_out[1][3], LE_out[0][2]}),
	.out(LE_out[0][3])
);

//-----------------------------------------FIM BORDA SUPERIOR-----------------------------------------------
newlogic_e le10(
	.saidas(saidas_LE[1][0]),
	.inp({LE_out[0][0], LE_out[1][1], LE_out[2][0], inp[1]}),
	.out(LE_out[1][0])
);

newlogic_e le11(
	.saidas(saidas_LE[1][1]),
	.inp({LE_out[0][1], LE_out[1][2], LE_out[2][1], LE_out[1][0]}),
	.out(LE_out[1][1])
);

newlogic_e le12(
	.saidas(saidas_LE[1][2]),
	.inp({LE_out[0][2], LE_out[1][3], LE_out[2][2], LE_out[1][1]}),
	.out(LE_out[1][2])
);


newlogic_e le13(				//--------------------------CANTO ESQUERDO
	.saidas(saidas_LE[1][3]),
	.inp({LE_out[0][3], 1'b0, LE_out[2][3], LE_out[1][2]}),
	.out(LE_out[1][3])
);

newlogic_e le20(
	.saidas(saidas_LE[2][0]),
	.inp({LE_out[1][0], LE_out[2][1], LE_out[3][0], inp[2]}),
	.out(LE_out[2][0])
);

newlogic_e le21(
	.saidas(saidas_LE[2][1]),
	.inp({LE_out[1][1], LE_out[2][2], LE_out[3][1], LE_out[2][0]}),
	.out(LE_out[2][1])
);

newlogic_e le22(
	.saidas(saidas_LE[2][2]),
	.inp({LE_out[1][2], LE_out[2][3], LE_out[3][2], LE_out[2][1]}),
	.out(LE_out[2][2])
);

newlogic_e le23(				//---------------------------CANTO ESQUERDO
	.saidas(saidas_LE[2][3]),
	.inp({LE_out[1][3], 1'b0, LE_out[3][3], LE_out[2][2]}),
	.out(LE_out[2][3])
);

//-----------------------------------------BORDA INFERIOR------------------------------------------------------
newlogic_e le30(
	.saidas(saidas_LE[3][0]),
	.inp({LE_out[2][0], LE_out[3][1], 1'b0, inp[3]}),
	.out(LE_out[3][0])
);

newlogic_e le31(
	.saidas(saidas_LE[3][1]),
	.inp({LE_out[2][1], LE_out[3][2], 1'b0, LE_out[3][0]}),
	.out(LE_out[3][1])
);

newlogic_e le32(
	.saidas(saidas_LE[3][2]),
	.inp({LE_out[2][2], LE_out[3][3], 1'b0, LE_out[3][1]}),
	.out(LE_out[3][2])
);

newlogic_e le33(				// ---------------------------CANTO ESQUERDO
	.saidas(saidas_LE[3][3]),
	.inp({LE_out[2][3], 1'b0, 1'b0, LE_out[3][2]}),
	.out(LE_out[3][3])
);

assign out = LE_out[out_chrom / 4][out_chrom % 4];

endmodule
