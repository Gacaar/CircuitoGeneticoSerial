parameter 
			 IN		= 3,
			 OUT	   = 1,
			 ROW	   = 3,
          COL     = 1,
			 TOTAL     = ROW*COL,
			 BITS_ELEM = $clog2(TOTAL),
//			 BITS_ELEM = 1,						// Usar no caso 1x1
			 BITS_MAT  = TOTAL*16,
			 
			 NUM_MUX = 4 * TOTAL,				// Numero de multiplexadores das entradas
			 BITS_SEL = $clog2(IN + 2),		// Numero de bits seletores para cada mux
			 BITS_MUX = NUM_MUX * BITS_SEL;  // Total de bits seletores

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




function integer clog2;
input integer value;
begin
value = value-1;
for (clog2=0; value>0; clog2=clog2+1)
value = value>>1;
end
endfunction
