parameter 
			 IN		  = 4,
			 OUT	 	  = 1,
			 ROW		  = 4,
			 COL 	  	  = 4;
			 
function integer clog2;
input integer value;
begin
value = value-1;
for (clog2=0; value>0; clog2=clog2+1)
value = value>>1;
end
endfunction

			 