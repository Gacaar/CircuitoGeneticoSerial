module ProcessamentoSerial
	( input wire iClock
	, input wire [3:0][7:0] iCurrentSerialInput
	, input wire [3:0][7:0] iCurrentSerialExpectedOutput
	, input wire [3:0][7:0] iCurrentSerialValidOutput
	, input wire [31:0] iSampleIndex
	
	// State machine control
	, input wire iPreparingNextSample
	, input wire iWriteSample
	, output wire oNextSample
	
	, output wire [NUM_SAMPLES:0][7:0] oInputSequences //NUM_SAMPLES EM TODOS ESSES OUTPUTS
	, output wire [NUM_SAMPLES:0][7:0] oExpectedOutputs
	, output wire [NUM_SAMPLES:0][7:0] oValidOutputs
	
	//TESTE 
	, output wire [23:0]verificacao
	);
	
	reg currentState = SEQ_IDLE;
	
//declarar registradores, fios e variaveis
	
	//saidas
	
	reg [NUM_SAMPLES:0][7:0] inputSequences;
	reg [NUM_SAMPLES:0][7:0] expectedOutputs;
	reg [NUM_SAMPLES:0][7:0] validOutputs;
			
	

//relacionar essas coisas com as entradas e saidas

assign oNextSample = 
	currentState == SEQ_IDLE;
assign oInputSequences = inputSequences;
assign oExpectedOutputs = expectedOutputs;
assign oValidOutputs = validOutputs;
assign verificacao = {inputSequences[23][1], inputSequences[22][1], inputSequences[21][1], inputSequences[20][1], inputSequences[19][1], inputSequences[18][1], inputSequences[17][1], inputSequences[16][1], inputSequences[15][1], inputSequences[14][1], inputSequences[13][1], inputSequences[12][1], inputSequences[11][1], inputSequences[10][1], inputSequences[9][1], inputSequences[8][1], inputSequences[7][1], inputSequences[6][1], inputSequences[5][1], inputSequences[4][1], inputSequences[3][1], inputSequences[2][1], inputSequences[1][1], inputSequences[0][1]};


//Funcionamento da maquina de estados

always@ (posedge iClock) begin

	//executado sempre no inicio, independente do estado
	//mantem o estado anterior
	inputSequences <= inputSequences;
	expectedOutputs <= expectedOutputs;
	validOutputs <= validOutputs;
	currentState <= currentState;
	
	case (currentState)
	SEQ_IDLE: begin   //SEQ_IDLE
		if (iPreparingNextSample) begin
			currentState <= WAITING_SAMPLE;
			//inputSequences[iSampleIndex] <= iCurrentSerialInput;
			//expectedOutputs[iSampleIndex] <= iCurrentSerialExpectedOutput;
			//validOutputs[iSampleIndex] <= iCurrentSerialValidOutput;
		end
	end
	
	WAITING_SAMPLE: begin //WAITING_SAMPLE
		if (iWriteSample) begin		
			inputSequences[iSampleIndex * 4] <= iCurrentSerialInput[0];
			inputSequences[iSampleIndex * 4 + 1] <= iCurrentSerialInput[1];
			inputSequences[iSampleIndex * 4 + 2] <= iCurrentSerialInput[2];
			inputSequences[iSampleIndex * 4 + 3] <= iCurrentSerialInput[3];
			expectedOutputs[iSampleIndex * 4] <= iCurrentSerialExpectedOutput[0];
			expectedOutputs[iSampleIndex * 4 + 1] <= iCurrentSerialExpectedOutput[1];
			expectedOutputs[iSampleIndex * 4 + 2] <= iCurrentSerialExpectedOutput[2];
			expectedOutputs[iSampleIndex * 4 + 3] <= iCurrentSerialExpectedOutput[3];
			validOutputs[iSampleIndex * 4] <= iCurrentSerialValidOutput[0];
			validOutputs[iSampleIndex * 4 + 1] <= iCurrentSerialValidOutput[1];
			validOutputs[iSampleIndex * 4 + 2] <= iCurrentSerialValidOutput[2];
			validOutputs[iSampleIndex * 4 + 3] <= iCurrentSerialValidOutput[3];
			currentState <= SEQ_IDLE;
			//oNextSample <= 1'b0;
		end
		
	end
	endcase
	
end


endmodule