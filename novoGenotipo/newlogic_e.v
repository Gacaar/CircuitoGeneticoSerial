module newlogic_e(
	input wire [15:0] saidas,
	input wire [3:0] inpu,
	output wire out
);

LCELL lcell_inst 
	  ( .in(saidas[inpu])
	  , .out(out)
	  );

endmodule
