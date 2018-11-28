   include "parameters.sv"

module chromosomeProcessingStateMachine
	( input wire iClock
	, input wire [3:0][7:0] iCurrentSerialInput
	, input wire [3:0][7:0] iCurrentSerialExpectedOutput
	, input wire [3:0][7:0] iCurrentSerialValidOutput
	, input wire [31:0] iSampleIndex
	
	// State machine control
	, input wire iPreparingNextSample
	, input wire iWriteSample
	, output wire oNextSample
	
	, output wire [NUM_SAMPLES:0][7:0] oInputSequences
	, output wire [NUM_SAMPLES:0][7:0] oExpectedOutputs
	, output wire [NUM_SAMPLES:0][7:0] oValidOutputs
	);
	
	parameter IDLE = 1'b0;
	
	reg currentState = IDLE;
	
---------------------------------------------
//declarar registradores, fios e variaveis
	
	//saidas
	
	reg [NUM_SAMPLES:0][7:0] inputSequences;
	reg [NUM_SAMPLES:0][7:0] expectedOutputs;
	reg [NUM_SAMPLES:0][7:0] validOutputs;
		
	

//relacionar essas coisas com as entradas e saidas

assign oNextSample = 
	currentState == IDLE;
assign oInputSequences = inputSequences;
assign oExpectedOutputs = expectedOutputs;
assign oValidOutputs = validOutputs;

//Funcionamento da maquina de estados

always@ (posedge iClock) begin

	//executado sempre no inicio, independente do estado
	//mantem o estado anterior
	inputSequences <= inputSequences;
	expectedOutput <= expectedOutput;
	validOutput <= validOutput;
	
	case (currentState)
	IDLE: begin
		if (iPreparingNextSample) begin		
			currentState <= WAITING_SAMPLE;
		end
	end
	
	WAITING_SAMPLE: begin
		if (iWriteSample) begin		
			inputSequences[iSampleIndex] <= iCurrentSerialInput;
			expectedOutput[iSampleIndex] <= iCurrentSerialExpectedOutput;
			validOutput[iSampleIndex] <= iCurrentSerialValidOutput;
			currentState <= IDLE;
		end
		
	end
	endcase
	
end


endmodule