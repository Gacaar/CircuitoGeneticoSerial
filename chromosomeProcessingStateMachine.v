module chromosomeProcessingStateMachine
	( input wire iClock
	, input wire [991:0] iConcatedChromDescription
	, input wire [NUM_SAMPLES:0][7:0] iInputSequence
	, input wire [NUM_SAMPLES:0][7:0] iExpectedOutput
	, input wire [NUM_SAMPLES:0][7:0] iValidOutput
	, input wire [7:0] iHardCodedInput
	, input wire iUseHardcodedInput
	, input wire iUseLastManualInput
	, input wire iLastRepetitionManualInput
	, input wire [1:0] iClockChangeCyclesSelector
	, input wire [7:0] iSequencesToProcess
	
	// State machine control
	, input wire iStartProcessing
	, input wire iDoneProcessingFeedback
	, output wire oReadyToProcess
	, output wire oDoneProcessing
	
	, output wire [31:0] oChromOutput
	, output wire [7:0][31:0] oErrorSums
	, output wire [2:0] oState
	
	, output wire [31:0] oMemContentToWrite
	, output wire [14:0] oMemAddr
	, output wire [14:0] oCorrectMemAddr
	, output wire oWriteToMem
	, output wire oWriteToCorrectMem
	//----------------------------------------- FIOS DE TESTE --------------------------------------------
	, input wire [7:0]iEntrada1
	, input wire [7:0]iEntrada2
	, input wire [7:0]iEntrada3
	, input wire [7:0]iEntrada4
	, input wire [7:0]iEntrada5
	, input wire [7:0]iEntrada6
	
	, output wire [7:0] oSaida				//SAIDAS DE TESTE DE MAX EL LOGIC
	, output wire [7:0] oSegundaSaida
	, output wire [7:0] oTerceiraSaida
	, output wire [7:0] oQuartaSaida
	, output wire [7:0] oQuintaSaida
	, output wire [7:0] oSextaSaida
	);
	
   `include "parameters.sv"
	
	reg [2:0] currentState = IDLE;
    
   reg [31:0] clockCycleCounter = 0;
   reg [7:0] currentInputIndex = 8'b0;
	reg [7:0] currentInput = 0;
	reg [7:0][31:0] currentErrorSums;
	reg [7:0][31:0] currentSamplingSum;
	reg [14:0] currentMemAddress;
	reg [14:0] currentCorrectMemAddress;
	reg manual;
	reg lastManualRepetitionInput;
	integer currentRetry;
   
	wire [31:0] clockChangeCycles;
	wire [31:0] chromosomeOutput;
	wire [7:0] SaidaTeste;		//	SAIDA DE TESTE PARA INSTANCIA
	wire [7:0] SaidaTeste2;	//SAIDA DE TESTE PARA INSTANCIA
	wire [7:0] SaidaTeste3;   //SAISA DE TESTE PARA INSTANCIA
	wire [7:0] SaidaTeste4;
	wire [7:0] SaidaTeste5;
	wire [7:0] SaidaTeste6;
	wire [991:0] chromDesc;

assign oReadyToProcess =
	currentState == IDLE;
	
assign oDoneProcessing =
	currentState == DONE;
	
assign oChromOutput = chromosomeOutput;

assign oSaida = SaidaTeste;				//TESTE DE INSTANCIA
assign oSegundaSaida = SaidaTeste2;		//TESTE DE INSTANCIA
assign oTerceiraSaida = SaidaTeste3;	//TESTE DE INSTANCIA
assign oQuartaSaida = SaidaTeste4;
assign oQuintaSaida = SaidaTeste5;
assign oSextaSaida = SaidaTeste6;

assign oState = currentState;

assign oErrorSums = currentErrorSums;

assign oWriteToMem = currentState == PROCESSING;

assign oWriteToCorrectMem = currentState == TRANSFER;

assign oMemAddr = currentMemAddress;

assign oCorrectMemAddr = currentCorrectMemAddress;

assign oMemContentToWrite = { currentInput
									 , currentInputIndex
									 , iExpectedOutput[currentInputIndex]
									 , chromosomeOutput[7:0] 
									 };

assign clockChangeCycles = 
		iClockChangeCyclesSelector == 2'b00 ? 100 :
		iClockChangeCyclesSelector == 2'b01 ? 500 :
		iClockChangeCyclesSelector == 2'b10 ? 1000 :
		2000;

always@ (posedge iClock) begin
	currentInputIndex <= currentInputIndex;
	clockCycleCounter <= clockCycleCounter;
	currentState <= currentState;
	currentInput <= iUseHardcodedInput ? iHardCodedInput : iInputSequence[currentInputIndex];
	currentErrorSums <= currentErrorSums;
	currentSamplingSum <= currentSamplingSum;
	currentMemAddress <= currentMemAddress;
	currentCorrectMemAddress <= currentMemAddress; // lags behind memAddr by 1.
	currentRetry <= currentRetry;
	lastManualRepetitionInput <= iLastRepetitionManualInput;
	manual <= manual;
	
	case (currentState)
	IDLE: begin
		if (iStartProcessing) begin
			currentInputIndex <= 0;
			currentErrorSums[0] <= 0;
			currentErrorSums[1] <= 0;
			currentErrorSums[2] <= 0;
			currentErrorSums[3] <= 0;
			currentErrorSums[4] <= 0;
			currentErrorSums[5] <= 0;
			currentErrorSums[6] <= 0;
			currentErrorSums[7] <= 0;
			currentState <= ZEROING_VRC;
			currentRetry <= 0;
			manual <= 0;
		end
	end
	ZEROING_VRC: begin
		currentMemAddress <= 15'b0;
		currentState <= INPUT_WAIT;
	end
	INPUT_WAIT: begin
		if (~manual || iLastRepetitionManualInput == 1'b1 && lastManualRepetitionInput == 1'b0) begin
			clockCycleCounter <= 0;
			currentSamplingSum[0] <= 0;
			currentSamplingSum[1] <= 0;
			currentSamplingSum[2] <= 0;
			currentSamplingSum[3] <= 0;
			currentSamplingSum[4] <= 0;
			currentSamplingSum[5] <= 0;
			currentSamplingSum[6] <= 0;
			currentSamplingSum[7] <= 0;
			currentState <= PROCESSING;
		end
	end
	PROCESSING: begin
		if (clockCycleCounter >= (clockChangeCycles - 1)) begin
			if (currentInputIndex >= (iSequencesToProcess - 1)) begin
				currentState <= CHECK_TRANSFER;
			end else begin
				currentInputIndex <= currentInputIndex + 8'b1;
				currentState <= INPUT_WAIT;
			end
			
			currentErrorSums[0] = currentErrorSums[0] + (currentSamplingSum[0] > 0 ? 1 : 0);
			currentErrorSums[1] = currentErrorSums[1] + (currentSamplingSum[1] > 0 ? 1 : 0);
			currentErrorSums[2] = currentErrorSums[2] + (currentSamplingSum[2] > 0 ? 1 : 0);
			currentErrorSums[3] = currentErrorSums[3] + (currentSamplingSum[3] > 0 ? 1 : 0);
			currentErrorSums[4] = currentErrorSums[4] + (currentSamplingSum[4] > 0 ? 1 : 0);
			currentErrorSums[5] = currentErrorSums[5] + (currentSamplingSum[5] > 0 ? 1 : 0);
			currentErrorSums[6] = currentErrorSums[6] + (currentSamplingSum[6] > 0 ? 1 : 0);
			currentErrorSums[7] = currentErrorSums[7] + (currentSamplingSum[7] > 0 ? 1 : 0);
		end else begin
			// Soma dos erros da saída do cromossomo
			if (clockCycleCounter >= CYCLES_TO_IGNORE) begin
				currentSamplingSum[0] = currentSamplingSum[0] + ((chromosomeOutput[0] ^ iExpectedOutput[currentInputIndex][0]) && iValidOutput[currentInputIndex][0]);
				currentSamplingSum[1] = currentSamplingSum[1] + ((chromosomeOutput[1] ^ iExpectedOutput[currentInputIndex][1]) && iValidOutput[currentInputIndex][1]);
				currentSamplingSum[2] = currentSamplingSum[2] + ((chromosomeOutput[2] ^ iExpectedOutput[currentInputIndex][2]) && iValidOutput[currentInputIndex][2]);
				currentSamplingSum[3] = currentSamplingSum[3] + ((chromosomeOutput[3] ^ iExpectedOutput[currentInputIndex][3]) && iValidOutput[currentInputIndex][3]);
				currentSamplingSum[4] = currentSamplingSum[4] + ((chromosomeOutput[4] ^ iExpectedOutput[currentInputIndex][4]) && iValidOutput[currentInputIndex][4]);
				currentSamplingSum[5] = currentSamplingSum[5] + ((chromosomeOutput[5] ^ iExpectedOutput[currentInputIndex][5]) && iValidOutput[currentInputIndex][5]);
				currentSamplingSum[6] = currentSamplingSum[6] + ((chromosomeOutput[6] ^ iExpectedOutput[currentInputIndex][6]) && iValidOutput[currentInputIndex][6]);
				currentSamplingSum[7] = currentSamplingSum[7] + ((chromosomeOutput[7] ^ iExpectedOutput[currentInputIndex][7]) && iValidOutput[currentInputIndex][7]); 
			end
			clockCycleCounter <= clockCycleCounter + 1;
		end
		
		currentMemAddress <= currentMemAddress + 15'b1;
	end
	SETUP_TRANSFER: begin
		currentState <= TRANSFER;
		currentMemAddress <= currentMemAddress + 15'b1;
	end
	TRANSFER: begin
		if (currentCorrectMemAddress == 15'h7FFF) begin
			currentState <= DONE;
		end else begin
			currentMemAddress <= currentMemAddress + 15'b1;
		end
	end
	CHECK_TRANSFER: begin
		if ((currentErrorSums[0]
			+ currentErrorSums[1]
			+ currentErrorSums[2]
			+ currentErrorSums[3]
			+ currentErrorSums[4]
			+ currentErrorSums[5]
			+ currentErrorSums[6]
			+ currentErrorSums[7]) == 31'b0) begin
			if (currentRetry >= NUM_RETRIES) begin
				currentMemAddress <= 15'b0;
				currentState <= SETUP_TRANSFER;
			end else if (currentRetry >= NUM_RETRIES - 1 && iUseLastManualInput) begin
				currentRetry <= currentRetry + 1;
				currentMemAddress <= 15'b0;
				currentInputIndex <= 0;
				manual <= 1;
				currentState <= INPUT_WAIT;
			end else begin
				currentRetry <= currentRetry + 1;
				currentMemAddress <= 15'b0;
				currentInputIndex <= 0;
				currentState <= INPUT_WAIT;
			end
		end else begin
			currentState <= DONE;
		end
	end
	DONE: begin
		if (iDoneProcessingFeedback) begin
			currentState <= IDLE;
		end
	end
	endcase
	
end

assign chromDesc = currentState == ZEROING_VRC ? 992'b0 : iConcatedChromDescription;

fenotipo fenotipo0 
	( .cromossomo(chromDesc)
	, .chromIn(currentInput)
	, .chromOut(chromosomeOutput)
	);
	
fenotipo fenotipo1 
	( .cromossomo(chromDesc)
	, .chromIn(iEntrada1)
	, .chromOut(SaidaTeste)
	);

fenotipo fenotipo2 
	( .cromossomo(chromDesc)
	, .chromIn(iEntrada2)
	, .chromOut(SaidaTeste2)
	);
	
fenotipo fenotipo3 
	( .cromossomo(chromDesc)
	, .chromIn(iEntrada3)
	, .chromOut(SaidaTeste3)
	);

fenotipo fenotipo4 
	( .cromossomo(chromDesc)
	, .chromIn(iEntrada4)
	, .chromOut(SaidaTeste4)
	);

fenotipo fenotipo5 
	( .cromossomo(chromDesc)
	, .chromIn(iEntrada5)
	, .chromOut(SaidaTeste5)
	);	

fenotipo fenotipo6 
	( .cromossomo(chromDesc)
	, .chromIn(iEntrada6)
	, .chromOut(SaidaTeste6)
	);
	
/*
Circuito2x2manual circ
	( .inp(inputToUse)
	, .out(chromosomeOutput)
	);


mem memModule
	( .address(currentAddress)
	, .clock(iClock)
	, .data({ inputToUse, { 4'b0, currentInput}, iExpectedOutput[currentInput], chromosomeOutput[7:0] })
	, .wren(writeToMemory)
	, .q()
	);
*/

endmodule