module managedmem(
	input iclk,
	input irst,
	input [15:0] iaddress,
	input ireadData,
	input iackReadData,
	input iwrite,
	input [7:0] iwriteContent,
	
	output [7:0] ocontent,
	output oready,
	output odataReady
);

   parameter READY = 2'b00,
	          READ1 = 2'b01,
				 READ2 = 2'b10,
				 DATA_READY = 2'b11;
				 
	wire [1:0] next_state = next_state_func(state, ireadData, iackReadData);
	reg [1:0] state = READY;
	
	function [1:0] next_state_func(input [1:0] currentState, input readData, input ackReadData);
		case(currentState)
			READY: begin
				if (readData) next_state_func = READ1;
				else next_state_func = READY;
			end
			READ1: next_state_func = READ2;
			READ2: next_state_func = DATA_READY;
			DATA_READY: begin
				if (ackReadData) next_state_func = READY;
				else next_state_func = DATA_READY;
			end
		endcase
	endfunction
		
always@(posedge iclk) begin
	state <= next_state;
end

always@(posedge iclk) begin
	case(state)
		READY: begin
			oready <= iwrite ? 1'b0 : 1'b1;
			odataReady <= 1'b0;
		end
		READ1: begin
			oready <= 1'b0;
			odataReady <= 1'b0;
		end
		READ2: begin
			oready <= 1'b0;
			odataReady <= 1'b0;
		end
		DATA_READY: begin
			oready <= 1'b0;
			odataReady <= 1'b1;
		end
	endcase
end

memory mem (
	.address(iaddress),
	.clock(iclk),
	.data(iwriteContent),
	.wren(iwrite),
	.q(ocontent)
);	
	
endmodule