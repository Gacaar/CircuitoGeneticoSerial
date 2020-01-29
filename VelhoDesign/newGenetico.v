module newGenetico(saidas_LE, out_chrom, inp, out);

	input wire [ROW-1:0][COL-1:0][15:0] saidas_LE; 	// Tabela verdade (saidas) de cada elemento
	input wire [OUT-1:0][$clog2(ROW*COL)-1:0] out_chrom; 		// Seletor do mux de saida
	input wire [IN-1:0] inp; 				// Entradas do circuito
	output wire [OUT-1:0] out;				// Saidas do circuito
	wire [ROW-1:0][COL-1:0]LE_out;				// Saida de cada elemento


	`include "parameters.sv"
	
	
	genvar i, j;
	generate
	for (i=0; i < ROW; i++)
	begin : lcellsi
		for(j = 0 ; j< COL; j++)
		begin: lcellsj
		// Determina o numero de ligacoes nos cantos e bordas (caso 1x1 nao necessario)
		if(ROW==1 || COL==1)
			begin
				localparam integer c = 3;
				localparam integer b = 2;
			end
		else
			begin
				localparam integer c = 2;
				localparam integer b = 1;
			end
		// Determina o numero de entradas que ja puderam ser colocadas
		if(i==0) //Primeira linha
			begin
				if(j==0) //Inicio linha
					begin
						localparam integer s = 0;
					end
				else //Meio ate fim da primeira linha
					begin
						localparam integer s = c+b*(j-1);
					end
			end
		else
			if(i<ROW-1) //Depois da primeira linha mas antes da ultima
				begin
					if(j==0) //Inicio da linha
						begin
							localparam integer s = (3-b)*c+COL-(3-b)+2*(i-1);
						end
					else //Meio a fim das linhas centrais. Nesse caso b=1 sempre
						begin
							localparam integer s = 2*c+COL-2+2*(i-1)+1;
						end
				end
			else //Na ultima linha
				begin
					if(j==0) //Inicio da ultima linha
						begin
							localparam integer s = (3-b)*c+COL-(3-b)+2*(i-1);
						end
					else //Meio a fim da ultima linha. Nesse caso b=1 sempre
						begin
							localparam integer s = 2*c+COL-2+2*(i-1)+c*(j-1);
						end
				end
			newlogic_e lcell( //NOVO LOGIC_E ???
				.saidas(saidas_LE[i][j]),
				.inp
					({j==0?(s<IN?inp[s]:1'b0):LE_out[i][j-1]
					, i==0?((j==0? s+1:s)<IN?(j==0?inp[s+1]:inp[s]):1'b0):LE_out[i-1][j]
					, j==COL-1?(((i==0 && j==0)?s+2:(i==0 || j==0)?s+1:s)<IN?((i==0 && j==0)?inp[s+2]:(i==0 || j==0)?inp[s+1]:inp[s]):1'b0):LE_out[i][j+1]
					, i==ROW-1?(((i==0 && j==0 && j==COL-1)?s+3:((i==0 && j==0)||(i==0 && j==COL-1)||(i==0 && j==COL-1))?s+2:(i==0 || j==0 || j==COL-1)?s+1:s)<IN?((i==0 && j==0 && j==COL-1)?inp[s+3]:((i==0 && i==0)||(j==0 && j==COL-1)||(i==0 && j==COL-1))?inp[s+2]:(i==0 || j==0 || j==COL-1)?inp[s+1]:inp[s]):1'b0):LE_out[i+1][j]
					}),
				.out(LE_out[i][j])
			);
		end
	end
	endgenerate
			

genvar k;
generate
for (k= 0; k< OUT ; k++)
begin : saida
	assign out[k] = LE_out[out_chrom[k] / COL][out_chrom[k] % COL];
end
endgenerate

endmodule
