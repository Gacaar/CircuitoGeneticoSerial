# Gerador do arquivo em verilog 'genotipo'

import numpy as np
import math
import sys

if(len(sys.argv) == 5):
    num_rows = int(sys.argv[1])
    num_cols = int(sys.argv[2])
    num_inp = int(sys.argv[3])
    num_out = int(sys.argv[4])
else:
    print("Insira 4 inteiros nessa ordem: num_row, num_col, num_in e num_out")
    sys.exit(2)

num_cells = num_rows*num_cols
max_inp = 2*num_cols+2*num_rows

if(num_inp > max_inp):
    print("Numero de entradas é maior que o possível")
    sys.exit(2)

# array que define quais possiveis entradas vao receber entradas externas
have_inp = np.zeros(max_inp)
have_inp[0:num_inp] = 1 # as entrdas estarao nas primeiras possiveis

file = open("newGenetico.v", "w+")

file.write("\
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
    ")

text = ""

for cell in range(0,num_cells):
    row = math.floor(cell/num_cols)
    col = cell%num_cols

    #faz as 4 ligacoes, comecando pela superior
    num_lig = [col, col+row+1, num_rows+2*num_cols-1-col, 2*num_rows+2*num_cols-1-row]
    if(row-1 >= 0):
        num_lig[0] = -1
    if(col+1 < num_cols):
        num_lig[1] = -1
    if(row+1 < num_rows):
        num_lig[2] = -1
    if(col-1 >= 0):
        num_lig[3] = -1


    text += "\n\
    //CELL " + str(cell) + "\n\
    newlogic_e lcell" + str(cell) + "( \n\
        .saidas(saidas_LE[" + str(row) + "][" + str(col) + "]),\n\
        .inpu({"

    if(num_lig[0] == -1):
        text += "LE_out["+str(row-1)+"]["+str(col)+"],"
    else:
        if(have_inp[num_lig[0]] == 1):
            text += "inp["+str(num_lig[0])+"],"
        else:
            text += "1'b0,"
    
    if(num_lig[1] == -1):
        text += "LE_out["+str(row)+"]["+str(col+1)+"],"
    else:
        if(have_inp[num_lig[1]] == 1):
            text += "inp["+str(num_lig[1])+"],"
        else:
            text += "1'b0,"

    if(num_lig[2] == -1):
        text += "LE_out["+str(row+1)+"]["+str(col)+"],"
    else:
        if(have_inp[num_lig[2]] == 1):
            text += "inp["+str(num_lig[2])+"],"
        else:
            text += "1'b0,"

    if(num_lig[3] == -1):
        text += "LE_out["+str(row)+"]["+str(col-1)+"]"
    else:
        if(have_inp[num_lig[3]] == 1):
            text += "inp["+str(num_lig[3])+"]"
        else:
            text += "1'b0"

    text += "}),\n\
		.out(LE_out["+str(row)+"]["+str(col)+"])\n\
	);"

file.write(text)

file.write("\n\n\
    genvar k;\n\
	generate\n\
	for (k= 0; k< OUT ; k++)\n\
	begin : saida\n\
		assign out[k] = LE_out[out_chrom[k] / COL][out_chrom[k] % COL];\n\
	end\n\
	endgenerate\n\
\n\
endmodule\n\
    ")

file.close()

file = open("parameters.sv", "w+")

file.write("\
parameter \n\
			 IN		   = "+str(num_inp)+",\n\
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