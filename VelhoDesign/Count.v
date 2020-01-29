module Count
(
	input wire entrada,
	output reg [11:0]data
);

//wire entrada;
//reg [11:0] data = 12'b000000000000;

//assign saida = data;

always@ (posedge entrada) begin
	
	data <= data + 1'b1; 

end
endmodule	