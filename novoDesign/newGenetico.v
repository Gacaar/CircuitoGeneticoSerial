
module newGenetico(saidas_LE, out_chrom, inp, out);

    input wire [ROW-1:0][COL-1:0][15:0] saidas_LE; 	// Tabela verdade (saidas) de cada elemento
    input wire [OUT-1:0][$clog2(ROW*COL)-1:0] out_chrom; 		// Seletor do mux de saida
    input wire [IN-1:0] inp; 				// Entradas do circuito
    output wire [OUT-1:0] out;				// Saidas do circuito
    wire [ROW-1:0][COL-1:0]LE_out;				// Saida de cada elemento


    `include "parameters.sv"
    
    //CELL 0
    newlogic_e lcell0( 
        .saidas(saidas_LE[0][0]),
        .inp({inp[0],1'b0,LE_out[1][0],1'b0}),
		.out(LE_out[0][0])
	);
    //CELL 1
    newlogic_e lcell1( 
        .saidas(saidas_LE[1][0]),
        .inp({LE_out[0][0],inp[1],1'b0,1'b0}),
		.out(LE_out[1][0])
	);
    genvar k;
	generate
	for (k= 0; k< OUT ; k++)
	begin : saida
		assign out[k] = LE_out[out_chrom[k] / COL][out_chrom[k] % COL];
	end
	endgenerate

endmodule
