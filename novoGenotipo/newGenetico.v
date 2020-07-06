
module newGenetico(saidas_LE, out_chrom, in_chrom, inp, out);

    input wire [ROW-1:0][COL-1:0][15:0] saidas_LE; 	// Tabela verdade (saidas) de cada elemento
    input wire [OUT-1:0][$clog2(ROW*COL)-1:0] out_chrom; 		// Seletor do mux de saida
	 input wire [TOTAL-1:0][(4*BITS_SEL)-1:0] in_chrom; // Seletor do mux de entrada
    input wire [IN-1:0] inp; 				// Entradas do circuito
    output wire [OUT-1:0] out;				// Saidas do circuito
    wire [ROW-1:0][COL-1:0]LE_out;				// Saida de cada elemento

    `include "parameters.sv"
	 
	 wire[(2**BITS_SEL)-1:0] mux00 = {inp[0], inp[0], 1'b0, 1'b0};
	 wire[(2**BITS_SEL)-1:0] mux01 = {inp[0], inp[0], 1'b0, 1'b0};
	 wire[(2**BITS_SEL)-1:0] mux02 = {inp[0], inp[0], 1'b0, 1'b0};
	 wire[(2**BITS_SEL)-1:0] mux03 = {inp[0], inp[0], 1'b0, 1'b0};
	 
//	 wire[BITS_SEL-1:0] mux10 = {inp[0], inp[1], LE_out[0][0], 1'b0};
//	 wire[BITS_SEL-1:0] mux11 = {inp[0], inp[1], 1'b0, 1'b0};
//	 wire[BITS_SEL-1:0] mux12 = {inp[0], inp[1], 1'b0, 1'b0};
//	 wire[BITS_SEL-1:0] mux13 = {inp[0], inp[1], 1'b0, 1'b0};
	 
    
    //CELL 0
    newlogic_e lcell0( 
        .saidas(saidas_LE[0][0]),
        .inp({mux00[in_chrom[0][1:0]],mux01[in_chrom[0][3:2]],mux02[in_chrom[0][5:4]],mux03[in_chrom[0][7:6]]}),
		  .out(LE_out[0][0])
	);
//    //CELL 1
//    newlogic_e lcell1( 
//        .saidas(saidas_LE[1][0]),
//        .inp({mux10[in_chrom[1][0]],mux11[in_chrom[1][1]],mux12[in_chrom[1][2]],mux13[in_chrom[1][3]]}),
//		  .out(LE_out[1][0])
//	);
	
    genvar k;
	generate
	for (k= 0; k< OUT ; k++)
	begin : saida
		assign out[k] = LE_out[out_chrom[k] / COL][out_chrom[k] % COL];
	end
	endgenerate

endmodule
