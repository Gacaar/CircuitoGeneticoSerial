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

text += "\
module newGenetico(saidas_LE, out_chrom, inp, out);\n\
\n\
    input wire [ROW-1:0][COL-1:0][15:0] saidas_LE; 	// Tabela verdade (saidas) de cada elemento\n\
    input wire [OUT-1:0][$clog2(ROW*COL)-1:0] out_chrom; 		// Seletor do mux de saida\n\
    input wire [IN-1:0] inp; 				// Entradas do circuito\n\
    output wire [OUT-1:0] out;				// Saidas do circuito\n\
    wire [ROW-1:0][COL-1:0]LE_out;				// Saida de cada elemento\n\
\n\
\n\
    `include \"parameters.sv\"\n\
    "

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

    text += "\n\
    //CELL " + str(cell) + "\n\
    newlogic_e lcell" + str(cell) + "( \n\
        .saidas(saidas_LE[" + str(row) + "][" + str(col) + "]),\n\
        .inp({"

    # flag que informa se cell ja recebeu algum input (cada cell deve receber somente um input)
    input_in_cell = False

    # Para cada entrada da cell: liga outra cell, input ou 0. A verificacao eh feita em cada linha, de cima para baixo, em cada coluna, da esquerda para a direita
    # Se a cell for receber um input, vai ser no primeiro lugar possivel. A verificacao na cell comeca em cima e vai no sentido horario
    for cell_input in range(0,4):
        if num_lig[cell_input] != 0:
            if num_lig[cell_input] == 1:
                text += "LE_out["+str(row-1)+"]["+str(col)+"],"
            elif num_lig[cell_input] == 2:
                text += "LE_out["+str(row)+"]["+str(col+1)+"],"
            elif num_lig[cell_input] == 3:
                text += "LE_out["+str(row+1)+"]["+str(col)+"],"
            elif num_lig[cell_input] == 4:
                text += "LE_out["+str(row)+"]["+str(col-1)+"],"    
        else:
            if inputs_placed < num_inputs and not input_in_cell:
                text += "inp["+str(inputs_placed)+"],"
                inputs_placed += 1
                input_in_cell = True
            else:
                text += "1'b0,"

    text += "}),\n\
		.out(LE_out["+str(row)+"]["+str(col)+"])\n\
	);"

if(num_inputs > inputs_placed):
    print("Numero de entradas é maior que o possível")
    sys.exit(2)

text += "\n\n\
    genvar k;\n\
	generate\n\
	for (k= 0; k< OUT ; k++)\n\
	begin : saida\n\
		assign out[k] = LE_out[out_chrom[k] / COL][out_chrom[k] % COL];\n\
	end\n\
	endgenerate\n\
\n\
endmodule\n\
    "


file = open("newGenetico.v", "w+")
file.write(text)
file.close()

file = open("parameters.sv", "w+")

file.write("\
parameter \n\
			 IN		   = "+str(num_inputs)+",\n\
			 OUT	   = "+str(num_out)+",\n\
			 ROW	   = "+str(num_rows)+",\n\
			 COL 	   = "+str(num_cols)+",\n\
			 TOTAL     = ROW*COL,\n\
			 BITS_ELEM = $clog2(TOTAL),\n\
			 BITS_MAT  = TOTAL*16;\n\
\n\
parameter IDLE = 3'b000,\n\
			 PROCESSING = 3'b001, \n\
			 DONE = 3'b010, \n\
			 SETUP_TRANSFER = 3'b011,\n\
			 INPUT_WAIT = 3'b100,\n\
			 ZEROING_VRC = 3'b101,\n\
			 TRANSFER = 3'b110,\n\
			 CHECK_TRANSFER = 3'b111;\n\
\n\
parameter TRANSFER_ST_IDLE = 2'b00,\n\
			 TRANSFER_ST_SETUP = 2'b01,\n\
			 TRANSFER_ST_TRANSFER = 2'b10;\n\
			 \n\
parameter NUM_RETRIES = 10000;\n\
\n\
parameter CYCLES_TO_IGNORE = 5;\n\
\n\
parameter NUM_SAMPLES = 1023,\n\
			 WAITING_SAMPLE = 1'b1,\n\
			 SEQ_IDLE = 1'b0;\n\
\n\
\n\
\n\
\n\
function integer clog2;\n\
input integer value;\n\
begin\n\
value = value-1;\n\
for (clog2=0; value>0; clog2=clog2+1)\n\
value = value>>1;\n\
end\n\
endfunction\n")

file.close()