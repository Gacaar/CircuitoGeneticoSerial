# Gerador dos arquivos em verilog 'genotipo' e 'parameters'
from math import floor, ceil, log
import sys

if(len(sys.argv) == 5):
    num_rows = int(sys.argv[1])
    num_cols = int(sys.argv[2])
    num_inputs = int(sys.argv[3])
    num_out = int(sys.argv[4])
else:
    print("Insira 4 inteiros nessa ordem: num_row, num_col, num_in e num_out")
    sys.exit(2)

# Definicoes da estrutura
num_cells = num_rows*num_cols
bits_sel = ceil(log(num_inputs+2, 2))
num_mux_inp = 2**bits_sel


text = ""

text += """
module newGenetico(saidas_LE, out_chrom, in_chrom, inp, out);

    input wire [ROW-1:0][COL-1:0][15:0] saidas_LE; 	// Tabela verdade (saidas) de cada elemento
    input wire [OUT-1:0][$clog2(ROW*COL)-1:0] out_chrom; 		// Seletor do mux de saida
	 input wire [TOTAL-1:0][(4*BITS_SEL)-1:0] in_chrom; // Seletor do mux de entrada
    input wire [IN-1:0] inp; 				// Entradas do circuito
    output wire [OUT-1:0] out;				// Saidas do circuito
    wire [ROW-1:0][COL-1:0]LE_out;				// Saida de cada elemento

    `include "parameters.sv"

    """

# numero de inputs colocados E indice do proximo input a ser ligado
inputs_placed = 0

# Para cada cell...
for cell in range(0,num_cells):
    text += f"//CELL {cell}\n"

    row = floor(cell/num_cols)
    col = cell%num_cols

    # Verifica quais ligacoes da cell devem ser ligadas com outras cells 
    num_lig = [0,0,0,0]
    if(row-1 >= 0):
        num_lig[0] = 1
    if(col+1 < num_cols):
        num_lig[1] = 2
    if(row+1 < num_rows):
        num_lig[2] = 3
    if(col-1 >= 0):
        num_lig[3] = 4

    # Cria um mux para cada entrada. O texto do mux eh colocado de tras para frente para facilitar a logica
    for cell_input in range(4):
        mux_txt = "};\n"
        # Comeca pelas entradas do circuito
        for inp in range(num_inputs):
            mux_txt = f", inp[{inp}]" + mux_txt
        # Liga com a cell vizinha, se houver
        if num_lig[cell_input] != 0:
            if num_lig[cell_input] == 1:
                mux_txt = f", LE_out[{row-1}][{col}]" + mux_txt
            elif num_lig[cell_input] == 2:
                mux_txt = f", LE_out[{row}][{col+1}]" + mux_txt
            elif num_lig[cell_input] == 3:
                mux_txt = f", LE_out[{row+1}][{col}]" + mux_txt
            elif num_lig[cell_input] == 4:
                mux_txt = f", LE_out[{row}][{col-1}]" + mux_txt
        else:
            mux_txt = ", 1'b0" + mux_txt
        # Completa com zeros
        for zeros in range(num_mux_inp-num_inputs-2):
            mux_txt = ", 1'b0" + mux_txt
        
        mux_txt = f"    wire[(2**BITS_SEL)-1:0] mux{cell}{cell_input} = {{1'b0" + mux_txt

        text += mux_txt

    text += f"""    
    newlogic_e lcell{cell}( 
        .saidas(saidas_LE[{row}][{col}]),
        .inp({{mux{cell}0[in_chrom[{cell}][{bits_sel*0}+:{bits_sel}]],mux{cell}1[in_chrom[{cell}][{bits_sel*1}+:{bits_sel}]],mux{cell}2[in_chrom[{cell}][{bits_sel*2}+:{bits_sel}]],mux{cell}3[in_chrom[{cell}][{bits_sel*3}+:{bits_sel}]]}}),
		  .out(LE_out[{row}][{col}])
    );
    """


text += """
    genvar k;
	generate
	for (k= 0; k< OUT ; k++)
	begin : saida
		assign out[k] = LE_out[out_chrom[k] / COL][out_chrom[k] % COL];
	end
	endgenerate

endmodule
"""


file = open("newGenetico.v", "w+")
file.write(text)
file.close()

file = open("parameters.sv", "w+")

file.write(
f"""parameter 
			 IN		= {num_inputs},
			 OUT	   = {num_out},
			 ROW	   = {num_rows},
          COL     = {num_cols},
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
""")

file.close()