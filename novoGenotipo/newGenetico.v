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
					({i==0?(s<IN?inp[s]:1'b0):LE_out[i-1][j]
					, j==COL-1?((i==0? s+1:s)<IN?(i==0?inp[s+1]:inp[s]):1'b0):LE_out[i][j+1]
					, i==ROW-1?(((j==COL-1 && i==0)?s+2:(j==COL-1 || i==0)?s+1:s)<IN?((j==COL-1 && i==0)?inp[s+2]:(j==COL-1 || i==0)?inp[s+1]:inp[s]):1'b0):LE_out[i+1][j]
					, j==0?(((j==COL-1 && i==0 && i==ROW-1)?s+3:((j==COL-1 && i==0)||(i==0 && i==ROW-1)||(j==COL-1 && i==ROW-1))?s+2:(j==COL-1 || i==0 || i==ROW-1)?s+1:s)<IN?((j==COL-1 && i==0 && i==ROW-1)?inp[s+3]:((j==COL-1 && i==0)||(i==0 && i==ROW-1)||(j==COL-1 && i==ROW-1))?inp[s+2]:(j==COL-1 || i==0 || i==ROW-1)?inp[s+1]:inp[s]):1'b0):LE_out[i][j-1]
					}),
				.out(LE_out[i][j])
			);
		end
	end
	endgenerate
			
/*
//--------------------------------------BORDA SUPERIOR-------------------------------------------------------	
newlogic_e le00( //NOVO LOGIC_E ???
	.saidas(saidas_LE[0][0]),
	.inp({1'b0, LE_out[0][1], LE_out[1][0], inp[0]}),
	.out(LE_out[0][0])
);

newlogic_e le01(
	.saidas(saidas_LE[0][1]),
	.inp({1'b0, LE_out[0][2], LE_out[1][1], LE_out[0][0]}),
	.out(LE_out[0][1])
);

newlogic_e le02(
	.saidas(saidas_LE[0][2]),
	.inp({1'b0, LE_out[0][3], LE_out[1][2], LE_out[0][1]}),
	.out(LE_out[0][2])
);

newlogic_e le03(				//------------------------CANTO DIREITO
	.saidas(saidas_LE[0][3]),
	.inp({1'b0, 1'b0, LE_out[1][3], LE_out[0][2]}),
	.out(LE_out[0][3])
);

//-----------------------------------------FIM BORDA SUPERIOR-----------------------------------------------
newlogic_e le10(
	.saidas(saidas_LE[1][0]),
	.inp({LE_out[0][0], LE_out[1][1], LE_out[2][0], inp[1]}),
	.out(LE_out[1][0])
);

newlogic_e le11(
	.saidas(saidas_LE[1][1]),
	.inp({LE_out[0][1], LE_out[1][2], LE_out[2][1], LE_out[1][0]}),
	.out(LE_out[1][1])
);

newlogic_e le12(
	.saidas(saidas_LE[1][2]),
	.inp({LE_out[0][2], LE_out[1][3], LE_out[2][2], LE_out[1][1]}),
	.out(LE_out[1][2])
);


newlogic_e le13(				//--------------------------CANTO DIREITO
	.saidas(saidas_LE[1][3]),
	.inp({LE_out[0][3], 1'b0, LE_out[2][3], LE_out[1][2]}),
	.out(LE_out[1][3])
);

newlogic_e le20(
	.saidas(saidas_LE[2][0]),
	.inp({LE_out[1][0], LE_out[2][1], LE_out[3][0], inp[2]}),
	.out(LE_out[2][0])
);

newlogic_e le21(
	.saidas(saidas_LE[2][1]),
	.inp({LE_out[1][1], LE_out[2][2], LE_out[3][1], LE_out[2][0]}),
	.out(LE_out[2][1])
);

newlogic_e le22(
	.saidas(saidas_LE[2][2]),
	.inp({LE_out[1][2], LE_out[2][3], LE_out[3][2], LE_out[2][1]}),
	.out(LE_out[2][2])
);

newlogic_e le23(				//---------------------------CANTO DIREITO
	.saidas(saidas_LE[2][3]),
	.inp({LE_out[1][3], 1'b0, LE_out[3][3], LE_out[2][2]}),
	.out(LE_out[2][3])
);

//-----------------------------------------BORDA INFERIOR------------------------------------------------------
newlogic_e le30(
	.saidas(saidas_LE[3][0]),
	.inp({LE_out[2][0], LE_out[3][1], 1'b0, inp[3]}),
	.out(LE_out[3][0])
);

newlogic_e le31(
	.saidas(saidas_LE[3][1]),
	.inp({LE_out[2][1], LE_out[3][2], 1'b0, LE_out[3][0]}),
	.out(LE_out[3][1])
);

newlogic_e le32(
	.saidas(saidas_LE[3][2]),
	.inp({LE_out[2][2], LE_out[3][3], 1'b0, LE_out[3][1]}),
	.out(LE_out[3][2])
);

newlogic_e le33(				// ---------------------------CANTO DIREITO
	.saidas(saidas_LE[3][3]),
	.inp({LE_out[2][3], 1'b0, 1'b0, LE_out[3][2]}),
	.out(LE_out[3][3])
);
*/
genvar k;
generate
for (k= 0; k< OUT ; k++)
begin : saida
	assign out[k] = LE_out[out_chrom[k] / ROW][out_chrom[k] % ROW];
end
endgenerate

endmodule
