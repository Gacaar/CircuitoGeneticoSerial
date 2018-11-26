module virtualFpga
	( input wow
	, output woah
	);
	
	parameter r = 5;
	parameter c = 5;
	
	wire [r - 1:0][c - 1:0] northOutputs;
	wire [r - 1:0][c - 1:0] eastOutputs;
	wire [r - 1:0][c - 1:0] westOutputs;
	wire [r - 1:0][c - 1:0] southOutputs;
	
	assign woah = northOutputs[0][2];
	
generate
genvar i, j;
for (i = 0; i < r; i = i + 1)
begin : outer
	for (j = 0; j < c; j = j + 1)
	begin : inner
		fpgaLE le
			( .lut({15'b0, wow})
			, .lutIns({2'b0, 2'b0, 2'b0, 2'b0})
			, .northOutputConf(2'b0)
			, .eastOutputConf(2'b0)
			, .westOutputConf(2'b0)
			, .southOutputConf(2'b0)
			
			, .northInput(i <= 0 ? 1'b0 : southOutputs[i - 1][j])
			, .eastInput(j >= (c - 1) ? 1'b0 : westOutputs[i][j + 1])
			, .westInput(j <= 0 ? 1'b0 : eastOutputs[i][j - 1])
			, .southInput(i >= (r - 1) ? 1'b0 : northOutputs[i + 1][j])
			
			, .northOutputLCell(northOutputs[i][j])
			, .eastOutputLCell(eastOutputs[i][j])
			, .westOutputLCell(westOutputs[i][j])
			, .southOutputLCell(southOutputs[i][j])
			);
	end
end
endgenerate

endmodule