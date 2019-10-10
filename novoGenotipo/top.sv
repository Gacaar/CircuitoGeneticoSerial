module top(
	input [259:0]cromossomo,
	input [3:0] inp,
	output out

);
	wire [3:0][3:0][15:0]descricao;
initial begin
	
	integer i,j, c ;
	for(i=0;i<4;i++)
	begin
		for(j=0;j<4;j++)
		begin
			c = 64*i +16*j;
			descricao[i][j] = cromossomo[15+c -: 15];
		end
	end
	
end

newGenetico genetico(
	.saidas_LE(descricao),
	.out_chrom(cromossomo[259:255]),
	.inp(inp),
	.out(out)
);

endmodule
