module newlogic_e(
	input wire [15:0] saidas,
	input wire [3:0] inp,
	output wire out
);

LCELL lcell_inst 
	  ( .in(saidas[inp])
	  , .out(out)
	  );

endmodule
