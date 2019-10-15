module top(
	input [259:0]cromossomo,
	input [3:0] inp,
	output out

);
	wire [3:0][3:0][15:0]descricao;
	
	genvar i, j;
	generate
	for(i = 0; i<4; i++)
	begin : teste
		for(j = 0; j < 4; j++)
		begin : teste2
			assign descricao[i][j] = cromossomo[15+64*i+16*j -: 15];
		end
	end
	endgenerate
	



newGenetico genetico(
	.saidas_LE(descricao),
	.out_chrom(cromossomo[259:255]),
	.inp(inp),
	.out(out)
);

endmodule
