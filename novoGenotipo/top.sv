	

module top(
	input [ROW*COL*16+$clog2(ROW*COL)*OUT-1:0]cromossomo,
	input [IN-1:0] inp,
	output [OUT-1:0]out

);


	`include "parameters.sv"

	wire [ROW-1:0][COL-1:0][15:0]descricao;
	
	genvar i, j;
	generate
	for(i = 0; i< ROW; i++)
	begin : teste
		for(j = 0; j < COL; j++)
		begin : teste2
			assign descricao[i][j] = cromossomo[15+COL*16*i+16*j -: 15];
		end
	end
	endgenerate
	


newGenetico genetico(
	.saidas_LE(descricao),
	.out_chrom(cromossomo[ROW*COL*16+$clog2(ROW*COL)*OUT-1:ROW*COL*16-1]),
	.inp(inp),
	.out(out)
);

endmodule
