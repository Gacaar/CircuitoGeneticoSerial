module newFenotipo(
	
	input [IN-1:0]inp,
	input [BITS_MAT+BITS_ELEM*OUT-1:0] cromossomo,
	output [OUT-1:0]out

);


	`include "parameters.sv"

	//tabela verdade de cada elemento
	wire [ROW-1:0][COL-1:0][15:0] descricao;
	wire [OUT-1:0][BITS_ELEM-1:0] out_chrom;
	
	genvar i, j;
	generate
	for(i = 0; i< ROW; i++)
	begin : teste
		for(j = 0; j < COL; j++)
		begin : teste2
			assign descricao[i][j] = cromossomo[15+COL*16*i+16*j -: 16];
		end
	end
	endgenerate
	

	genvar k;
	generate
	for(k=0;k<OUT;k++)
	begin: outi
		assign out_chrom[k] = cromossomo[((BITS_MAT + (BITS_ELEM * (k + 1))) - 1) -: BITS_ELEM];
		//assign out_chrom[k] = cromossomo[32 : 32];
	end
	endgenerate
	

newGenetico genetico(
	.saidas_LE(descricao),
	.out_chrom(out_chrom),
	.inp(inp),
	.out(out)
);

endmodule
