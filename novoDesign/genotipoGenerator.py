# Gerador do arquivo em verilog 'genotipo'

import numpy as np
import math
import sys

if(len(sys.argv) == 5):
    num_rows = int(sys.argv[1])
    num_cols = int(sys.argv[2])
    num_inputs = int(sys.argv[3])
    num_out = int(sys.argv[4])
else:
    print("Insira 4 inteiros nessa ordem: num_row, num_col, num_in e num_out")
    sys.exit(2)

num_cells = num_rows*num_cols

text = ""

text += """
module newGenetico(saidas_LE, out_chrom, inp, out);

    input wire [ROW-1:0][COL-1:0][15:0] saidas_LE; 	// Tabela verdade (saidas) de cada elemento
    input wire [OUT-1:0][$clog2(ROW*COL)-1:0] out_chrom; 		// Seletor do mux de saida
    input wire [IN-1:0] inp; 				// Entradas do circuito
    output wire [OUT-1:0] out;				// Saidas do circuito
    wire [ROW-1:0][COL-1:0]LE_out;				// Saida de cada elemento


    `include \"parameters.sv\"
    """

# numero de inputs colocados E indice do proximo input a ser ligado
inputs_placed = 0

# Para cada cell...
for cell in range(0,num_cells):
    row = math.floor(cell/num_cols)
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

    text += f"""
    //CELL {cell}
    newlogic_e lcell{cell}( 
        .saidas(saidas_LE[{row}][{col}]),
        .inp({{"""

    # flag que informa se cell ja recebeu algum input (cada cell deve receber somente um input)
    input_in_cell = False

    # Para cada entrada da cell: liga outra cell, input ou 0. A verificacao eh feita em cada linha, de cima para baixo, em cada coluna, da esquerda para a direita
    # Se a cell for receber um input, vai ser no primeiro lugar possivel. A verificacao na cell comeca em cima e vai no sentido horario
    for cell_input in range(0,4):
        if num_lig[cell_input] != 0:
            if num_lig[cell_input] == 1:
                text += f"LE_out[{row-1}][{col}],"
            elif num_lig[cell_input] == 2:
                text += f"LE_out[{row}][{col+1}],"
            elif num_lig[cell_input] == 3:
                text += f"LE_out[{row+1}][{col}],"
            elif num_lig[cell_input] == 4:
                text += f"LE_out[{row}][{col-1}]"    
        else:
            if inputs_placed < num_inputs and not input_in_cell:
                text += f"inp[{inputs_placed}]"+ ("," if cell_input != 3 else "")
                inputs_placed += 1
                input_in_cell = True
            else:
                text += "1'b0"+("," if cell_input != 3 else "")

    text += f"""}}),
		.out(LE_out[{row}][{col}])
	);"""

if(num_inputs > inputs_placed):
    print("Numero de entradas é maior que o possível")
    sys.exit(2)

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
			 COL 	   = {num_cols},
			 TOTAL     = ROW*COL,
			 BITS_ELEM = $clog2(TOTAL),
			 BITS_MAT  = TOTAL*16;

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