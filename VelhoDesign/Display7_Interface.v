module Display7_Interface (
	output [6:0] HEX0, HEX1, HEX2,	// Displays Hex
	input wire SW0
	);
	
wire [11:0]contagem;

Count verificador(
	.entrada(SW0),
	.data(contagem[11:0])
);


Decoder7 Dec0 (
	.in(contagem[3:0]),
	.out(HEX0)
	);

Decoder7 Dec1 (
	.in(contagem[7:4]),
	.out(HEX1)
	);

Decoder7 Dec2 (
	.in(contagem[11:8]),
	.out(HEX2)
	);
	
endmodule