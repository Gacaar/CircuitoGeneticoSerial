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
assign verificacao = {expectedOutputs[23][1], expectedOutputs[22][1], expectedOutputs[21][1], expectedOutputs[20][1], expectedOutputs[19][1], expectedOutputs[18][1], expectedOutputs[17][1], expectedOutputs[16][1], expectedOutputs[15][1], expectedOutputs[14][1], expectedOutputs[13][1], expectedOutputs[12][1], expectedOutputs[11][1], expectedOutputs[10][1], expectedOutputs[9][1], expectedOutputs[8][1], expectedOutputs[7][1], expectedOutputs[6][1], expectedOutputs[5][1], expectedOutputs[4][1], expectedOutputs[3][1], expectedOutputs[2][1], expectedOutputs[1][1], expectedOutputs[0][1]};


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
			inputSequences[iSampleIndex] <= iCurrentSerialInput;
			expectedOutputs[iSampleIndex] <= iCurrentSerialExpectedOutput;
			validOutputs[iSampleIndex] <= iCurrentSerialValidOutput;
			currentState <= SEQ_IDLE;
			//oNextSample <= 1'b0;
		end
		
	end
	endcase
	
end


endmodule