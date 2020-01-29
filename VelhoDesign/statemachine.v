module statemachine(
	input iclk,
	input irst,
	output reg [15:0] oaddr,
	output reg [7:0] ocontent,
	output reg owrite,
	output reg odone
);

	parameter IDLE = 2'b00,
	          FILLING = 2'b01,
				 DONE = 2'b10;

   wire [1:0] next_state = next_state_fun(irst, state, oaddr);
	reg [1:0] state = IDLE;
	
	function [1:0] next_state_fun(input irst, input [2:0] current_state, input [15:0] address);
		if (irst) begin
			next_state_fun = IDLE;
		end else begin
			case(current_state)
			IDLE: next_state_fun = FILLING;
			FILLING: begin
				if (address == 16'hFFFF) begin
					next_state_fun = DONE;
				end else begin
					next_state_fun = FILLING;
				end
			end
			DONE: next_state_fun = DONE;
			default: next_state_fun = IDLE;
			endcase
		end
	endfunction
		
always@(posedge iclk) begin
	state <= next_state;
end

always@(posedge iclk) begin
	case(state)
	IDLE: begin
		oaddr <= 8'b0;
		ocontent <= 8'b0;
		owrite <= 1'b0;
		odone <= 1'b0;
	end
	FILLING: begin
		oaddr <= oaddr + 16'b1;
		ocontent <= ocontent + 8'b1;
		owrite <= 1'b1;
		odone <= 1'b0;
	end
	DONE: begin
		oaddr <= oaddr;
		ocontent <= ocontent;
		owrite <= 1'b0;
		odone <= 1'b1;
	end
	endcase
end

endmodule
