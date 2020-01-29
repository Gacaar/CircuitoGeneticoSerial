parameter IDLE = 3'b000,
			 PROCESSING = 3'b001, 
			 DONE = 3'b010, 
			 SETUP_TRANSFER = 3'b011,
			 INPUT_WAIT = 3'b100,
			 ZEROING_VRC = 3'b101,
			 TRANSFER = 3'b110,
			 CHECK_TRANSFER = 3'b111;

parameter TRANSFER_ST_IDLE = 2'b00,
			 TRANSFER_ST_SETUP = 2'b01,
			 TRANSFER_ST_TRANSFER = 2'b10;
			 
parameter NUM_RETRIES = 10000;

parameter CYCLES_TO_IGNORE = 5;

parameter NUM_SAMPLES = 1023,
			 WAITING_SAMPLE = 1'b1,
			 SEQ_IDLE = 1'b0;
			 
parameter 
			 IN		  = 2,
			 OUT	 	  = 1,
			 ROW		  = 10,
			 COL 	  	  = 6,
			 TOTAL     = ROW*COL,
			 BITS_ELEM = $clog2(TOTAL),
			 BITS_MAT  = TOTAL*16;
			 
function integer clog2;
input integer value;
begin
value = value-1;
for (clog2=0; value>0; clog2=clog2+1)
value = value>>1;
end
endfunction

