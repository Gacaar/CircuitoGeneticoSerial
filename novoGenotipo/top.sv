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
	assign cromossomo = 1024'b11111111_0_0101111101000000;
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
	

//	genvar k;
//	generate
//	for(k=0;k<OUT;k++)
//	begin: outi
//		assign out_chrom[k] = cromossomo[((BITS_MAT + (BITS_ELEM * (k + 1))) - 1) -: BITS_ELEM];
//	end
//	endgenerate
	
	assign out_chrom[0] = cromossomo[16:16];
	
	
	assign in_chrom[0][1:0] = cromossomo[18:17];
	assign in_chrom[0][3:2] = cromossomo[20:19];
	assign in_chrom[0][5:4] = cromossomo[22:21];
	assign in_chrom[0][7:6] = cromossomo[24:23];
	
//	assign in_chrom[0][0] = cromossomo[34:33];
//	assign in_chrom[0][1] = cromossomo[36:35];
//	assign in_chrom[0][2] = cromossomo[38:37];
//	assign in_chrom[0][3] = cromossomo[40:39];
//	assign in_chrom[1][0] = cromossomo[42:41];
//	assign in_chrom[1][1] = cromossomo[44:43];
//	assign in_chrom[1][2] = cromossomo[46:45];
//	assign in_chrom[1][3] = cromossomo[48:47];
	
	
//	genvar a, b;
//	generate
//	for(a = 0; a< TOTAL; a++)
//	begin : in1
//		for(b = 0; b < 4; b++)
//		begin : in2
//			assign in_chrom[a][b] = cromossomo[BITS_MAT +
//														 (OUT * BITS_ELEM) +
//														 (a*4*BITS_SEL) + (b*BITS_SEL)  +: BITS_SEL];
//		end
//	end
//	endgenerate
	

newGenetico genetico(
	.saidas_LE(descricao),
	.out_chrom(out_chrom),
	.in_chrom(in_chrom),
	.inp(inp),
	.out(out)
);

endmodule