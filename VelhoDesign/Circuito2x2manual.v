module Circuito2x2manual
	( input [1:0] inp
	, output out
	);


	wire w0, w1, w2, w3;
	wire L0, L1, L2, L3;

	nand el0 (L0, inp[1], w2);
	nand el1 (L1, w0, w2);
	xnor el2 (L2, w0, w3);
	or   el3 (L3, inp[0], w2);
	
	assign out = L1;
	
LCELL lcell_inst0
  ( .in(L0)
  , .out(w0)
  );

LCELL lcell_inst1
  ( .in(L1)
  , .out(w1)
  );

LCELL lcell_inst2
  ( .in(L2)
  , .out(w2)
  );
  
LCELL lcell_inst3
  ( .in(L3)
  , .out(w3)
  );
	
endmodule
