parameter 
			 IN		  = 2,
			 OUT	 	  = 2,
			 ROW		  = 1,
			 COL 	  	  = 2,
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

			 