module top(
	
	input [9:0]SW,
	output [9:0]LEDR

);

	wire [OUT-1:0] out;
	wire [BITS_MAT+BITS_ELEM*OUT+BITS_MUX-1:0] cromossomo;
	wire [IN-1:0] inp;
	
//	assign cromossomo[15:0] =  16'b1111_1111_0000_0000;//menos significativo direita
//	assign cromossomo[31:16] = 16'b1111_0000_0000_0000;
//	assign cromossomo[32:32] = 1'b1;
//3312_3230
//	assign cromossomo = 1024'b11110110_11101100_100110100001000100101111101000000; //AND 2x1
	//4423_4313_4340
	assign cromossomo = 1024'b100_100_010_011__100_011_001_011__100_011_100_000__01111101100011000001011110010000101000111101011010; //Maioria3 3x1
	assign inp = SW[IN-1:0];
	assign LEDR = out;

	`include "parameters.sv"

	//tabela verdade de cada elemento
	wire [ROW-1:0][COL-1:0][15:0] descricao;
	wire [OUT-1:0][BITS_ELEM-1:0] out_chrom;
	wire [TOTAL-1:0][(4*BITS_SEL)-1:0] in_chrom;
	
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
	end
	endgenerate
	
	
	
	genvar a, b;
	generate
	for(a = 0; a< TOTAL; a++)
	begin : in1
		for(b = 0; b < 4; b++)
		begin : in2
			assign in_chrom[a][b*BITS_SEL+:BITS_SEL] = cromossomo[BITS_MAT +
														 (OUT * BITS_ELEM) +
														 (a*4*BITS_SEL) + (b*BITS_SEL)  +: BITS_SEL];
		end
	end
	endgenerate
	

newGenetico genetico(
	.saidas_LE(descricao),
	.out_chrom(out_chrom),
	.in_chrom(in_chrom),
	.inp(inp),
	.out(out)
);

endmodule