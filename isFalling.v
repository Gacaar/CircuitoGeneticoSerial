module isFalling
	( input iClock
	, input iInp
	, output oFalling
	);
	
	reg last = 1'b0;
	
	assign oFalling = last == 1'b1 && iInp == 1'b0;
	
always @(posedge iClock) begin
	last <= iInp;
end
	
endmodule