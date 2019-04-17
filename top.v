module top(
	// FPGA
	input wire CLOCK_50,
	output wire [9:0] LEDR,
	input wire [9:0] SW,
	input wire [3:0] KEY,
	// HPS
	inout wire HPS_CONV_USB_N,
	output wire [14:0] HPS_DDR3_ADDR,
	output wire [2:0] HPS_DDR3_BA,
	output wire HPS_DDR3_CAS_N,
	output wire HPS_DDR3_CKE,
	output wire HPS_DDR3_CK_N,
	output wire HPS_DDR3_CK_P,
	output wire HPS_DDR3_CS_N,
	output wire [3:0] HPS_DDR3_DM,
	inout wire [31:0] HPS_DDR3_DQ,
	inout [3:0] HPS_DDR3_DQS_N,
	inout [3:0] HPS_DDR3_DQS_P,
	output wire HPS_DDR3_ODT,
	output wire HPS_DDR3_RAS_N,
	output wire HPS_DDR3_RESET_N,
	input wire HPS_DDR3_RZQ,
	output wire HPS_DDR3_WE_N,
	output wire HPS_ENET_GTX_CLK,
	inout wire HPS_ENET_INT_N,
	output wire HPS_ENET_MDC,
	inout wire HPS_ENET_MDIO,
	input wire HPS_ENET_RX_CLK,
	input wire [3:0] HPS_ENET_RX_DATA,
	input wire HPS_ENET_RX_DV,
	output wire [3:0] HPS_ENET_TX_DATA,
	output wire HPS_ENET_TX_EN,
	inout wire HPS_KEY,
	output wire HPS_SD_CLK,
	inout wire HPS_SD_CMD,
	inout wire [3:0] HPS_SD_DATA,
	input wire HPS_UART_RX,
	output wire HPS_UART_TX,
	input wire HPS_USB_CLKOUT,
	inout wire [7:0] HPS_USB_DATA,
	input wire HPS_USB_DIR,
	input wire HPS_USB_NXT,
	output wire HPS_USB_STP,
	
	//TESTE
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5	// Displays Hex
);


wire [31:0] rawChromInput[30:0];
wire [991:0] concatedChromInput;
wire [7:0][31:0] errorSumOutput;

wire [3:0][7:0] inputSequencesSample;
wire [3:0][7:0] expectedOutputsSample;
wire [3:0][7:0] validOutputsSample;
wire writeSample;
wire [31:0] sampleIndex;
wire [NUM_SAMPLES:0][7:0] inputSequences;
wire [NUM_SAMPLES:0][7:0] expectedOutputs;
wire [NUM_SAMPLES:0][7:0] validOutputs;
wire nextSample;
wire preparingNextSample;

wire [7:0] sequencesToProcess;
wire [31:0] chromOutput;
wire [15:0] chosenOutput;
wire [7:0] outputToShow;
wire [1:0] state;

wire [14:0] memAddress;
wire [14:0] correctMemAddress;
wire [31:0] memReadData;
wire [31:0] memWriteData;
wire writeToMem;
wire writeToCorrectMem;

wire startProcessingChrom;
wire readyToProcess;
wire doneProcessingFeedback;
wire doneProcessingChrom;

wire doneFilling;

assign LEDR[6:0] = chromOutput[6:0];
assign LEDR[9:8] = state;
//assign LEDR[9] = nextSample;//state;
//assign LEDR[8] = preparingNextSample;
//TESTE DE SINAL DO PROCESSAMENTOSERIAL
wire [23:0]teste;

assign concatedChromInput = {
	rawChromInput[30],
	rawChromInput[29],
	rawChromInput[28],
	rawChromInput[27],
	rawChromInput[26],
	rawChromInput[25],
	rawChromInput[24],
	rawChromInput[23],
	rawChromInput[22],
	rawChromInput[21],
	rawChromInput[20],
	rawChromInput[19],
	rawChromInput[18],
	rawChromInput[17],
	rawChromInput[16],
	rawChromInput[15],
	rawChromInput[14],
	rawChromInput[13],
	rawChromInput[12],
	rawChromInput[11],
	rawChromInput[10],
	rawChromInput[9],
	rawChromInput[8],
	rawChromInput[7],
	rawChromInput[6],
	rawChromInput[5],
	rawChromInput[4],
	rawChromInput[3],
	rawChromInput[2],
	rawChromInput[1],
	rawChromInput[0]
};

testeio u0 (
        .clk_clk                             (CLOCK_50),
        .hps_io_hps_io_emac1_inst_TX_CLK     (HPS_ENET_GTX_CLK),     //                       hps_io.hps_io_emac1_inst_TX_CLK
        .hps_io_hps_io_emac1_inst_TXD0       (HPS_ENET_TX_DATA[0]),       //                             .hps_io_emac1_inst_TXD0
        .hps_io_hps_io_emac1_inst_TXD1       (HPS_ENET_TX_DATA[1]),       //                             .hps_io_emac1_inst_TXD1
        .hps_io_hps_io_emac1_inst_TXD2       (HPS_ENET_TX_DATA[2]),       //                             .hps_io_emac1_inst_TXD2
        .hps_io_hps_io_emac1_inst_TXD3       (HPS_ENET_TX_DATA[3]),       //                             .hps_io_emac1_inst_TXD3
        .hps_io_hps_io_emac1_inst_RXD0       (HPS_ENET_RX_DATA[0]),       //                             .hps_io_emac1_inst_RXD0
        .hps_io_hps_io_emac1_inst_MDIO       (HPS_ENET_MDIO),       //                             .hps_io_emac1_inst_MDIO
        .hps_io_hps_io_emac1_inst_MDC        (HPS_ENET_MDC),        //                             .hps_io_emac1_inst_MDC
        .hps_io_hps_io_emac1_inst_RX_CTL     (HPS_ENET_RX_DV),     //                             .hps_io_emac1_inst_RX_CTL
        .hps_io_hps_io_emac1_inst_TX_CTL     (HPS_ENET_TX_EN),     //                             .hps_io_emac1_inst_TX_CTL
        .hps_io_hps_io_emac1_inst_RX_CLK     (HPS_ENET_RX_CLK),     //                             .hps_io_emac1_inst_RX_CLK
        .hps_io_hps_io_emac1_inst_RXD1       (HPS_ENET_RX_DATA[1]),       //                             .hps_io_emac1_inst_RXD1
        .hps_io_hps_io_emac1_inst_RXD2       (HPS_ENET_RX_DATA[2]),       //                             .hps_io_emac1_inst_RXD2
        .hps_io_hps_io_emac1_inst_RXD3       (HPS_ENET_RX_DATA[3]),       //                             .hps_io_emac1_inst_RXD3
        .hps_io_hps_io_sdio_inst_CMD         (HPS_SD_CMD),         //                             .hps_io_sdio_inst_CMD
        .hps_io_hps_io_sdio_inst_D0          (HPS_SD_DATA[0]),          //                             .hps_io_sdio_inst_D0
        .hps_io_hps_io_sdio_inst_D1          (HPS_SD_DATA[1]),          //                             .hps_io_sdio_inst_D1
        .hps_io_hps_io_sdio_inst_CLK         (HPS_SD_CLK),         //                             .hps_io_sdio_inst_CLK
        .hps_io_hps_io_sdio_inst_D2          (HPS_SD_DATA[2]),          //                             .hps_io_sdio_inst_D2
        .hps_io_hps_io_sdio_inst_D3          (HPS_SD_DATA[3]),          //                             .hps_io_sdio_inst_D3
        .hps_io_hps_io_usb1_inst_D0          (HPS_USB_DATA[0]),          //                             .hps_io_usb1_inst_D0
        .hps_io_hps_io_usb1_inst_D1          (HPS_USB_DATA[1]),          //                             .hps_io_usb1_inst_D1
        .hps_io_hps_io_usb1_inst_D2          (HPS_USB_DATA[2]),          //                             .hps_io_usb1_inst_D2
        .hps_io_hps_io_usb1_inst_D3          (HPS_USB_DATA[3]),          //                             .hps_io_usb1_inst_D3
        .hps_io_hps_io_usb1_inst_D4          (HPS_USB_DATA[4]),          //                             .hps_io_usb1_inst_D4
        .hps_io_hps_io_usb1_inst_D5          (HPS_USB_DATA[5]),          //                             .hps_io_usb1_inst_D5
        .hps_io_hps_io_usb1_inst_D6          (HPS_USB_DATA[6]),          //                             .hps_io_usb1_inst_D6
        .hps_io_hps_io_usb1_inst_D7          (HPS_USB_DATA[7]),          //                             .hps_io_usb1_inst_D7
        .hps_io_hps_io_usb1_inst_CLK         (HPS_USB_CLKOUT),         //                             .hps_io_usb1_inst_CLK
        .hps_io_hps_io_usb1_inst_STP         (HPS_USB_STP),         //                             .hps_io_usb1_inst_STP
        .hps_io_hps_io_usb1_inst_DIR         (HPS_USB_DIR),         //                             .hps_io_usb1_inst_DIR
        .hps_io_hps_io_usb1_inst_NXT         (HPS_USB_NXT),         //                             .hps_io_usb1_inst_NXT
        .hps_io_hps_io_uart0_inst_RX         (HPS_UART_RX),         //                             .hps_io_uart0_inst_RX
        .hps_io_hps_io_uart0_inst_TX         (HPS_UART_TX),         //                             .hps_io_uart0_inst_TX
        .memory_mem_a                        (HPS_DDR3_ADDR),                        //                       memory.mem_a
        .memory_mem_ba                       (HPS_DDR3_BA),                       //                             .mem_ba
        .memory_mem_ck                       (HPS_DDR3_CK_P),                       //                             .mem_ck
        .memory_mem_ck_n                     (HPS_DDR3_CK_N),                     //                             .mem_ck_n
        .memory_mem_cke                      (HPS_DDR3_CKE),                      //                             .mem_cke
        .memory_mem_cs_n                     (HPS_DDR3_CS_N),                     //                             .mem_cs_n
        .memory_mem_ras_n                    (HPS_DDR3_RAS_N),                    //                             .mem_ras_n
        .memory_mem_cas_n                    (HPS_DDR3_CAS_N),                    //                             .mem_cas_n
        .memory_mem_we_n                     (HPS_DDR3_WE_N),                     //                             .mem_we_n
        .memory_mem_reset_n                  (HPS_DDR3_RESET_N),                  //                             .mem_reset_n
        .memory_mem_dq                       (HPS_DDR3_DQ),                       //                             .mem_dq
        .memory_mem_dqs                      (HPS_DDR3_DQS_P),                      //                             .mem_dqs
        .memory_mem_dqs_n                    (HPS_DDR3_DQS_N),                    //                             .mem_dqs_n
        .memory_mem_odt                      (HPS_DDR3_ODT),                      //                             .mem_odt
        .memory_mem_dm                       (HPS_DDR3_DM),                       //                             .mem_dm
        .memory_oct_rzqin                    (HPS_DDR3_RZQ),                    //                             .oct_rzqin
		  .reset_reset_n                       (1'b1),
		  .chrom_seg_0_export                  (rawChromInput[0]),              //    chrom_seg_0.export
        .chrom_seg_1_export                  (rawChromInput[1]),              //    chrom_seg_1.export
        .chrom_seg_2_export                  (rawChromInput[2]),              //    chrom_seg_2.export
        .chrom_seg_3_export                  (rawChromInput[3]),              //    chrom_seg_3.export
        .chrom_seg_4_export                  (rawChromInput[4]),              //    chrom_seg_4.export
        .chrom_seg_5_export                  (rawChromInput[5]),              //    chrom_seg_5.export
        .chrom_seg_6_export                  (rawChromInput[6]),              //    chrom_seg_6.export
        .chrom_seg_7_export                  (rawChromInput[7]),              //    chrom_seg_7.export
        .chrom_seg_8_export                  (rawChromInput[8]),              //    chrom_seg_8.export
        .chrom_seg_9_export                  (rawChromInput[9]),              //    chrom_seg_9.export
        .chrom_seg_10_export                 (rawChromInput[10]),             //   chrom_seg_10.export
        .chrom_seg_11_export                 (rawChromInput[11]),             //   chrom_seg_11.export
        .chrom_seg_12_export                 (rawChromInput[12]),             //   chrom_seg_12.export
        .chrom_seg_13_export                 (rawChromInput[13]),             //   chrom_seg_13.export
        .chrom_seg_14_export                 (rawChromInput[14]),             //   chrom_seg_14.export
        .chrom_seg_15_export                 (rawChromInput[15]),             //   chrom_seg_15.export
        .chrom_seg_16_export                 (rawChromInput[16]),             //   chrom_seg_16.export
        .chrom_seg_17_export                 (rawChromInput[17]),             //   chrom_seg_17.export
        .chrom_seg_18_export                 (rawChromInput[18]),             //   chrom_seg_18.export
        .chrom_seg_19_export                 (rawChromInput[19]),             //   chrom_seg_19.export
        .chrom_seg_20_export                 (rawChromInput[20]),             //   chrom_seg_20.export
        .chrom_seg_21_export                 (rawChromInput[21]),             //   chrom_seg_21.export
        .chrom_seg_22_export                 (rawChromInput[22]),             //   chrom_seg_22.export
        .chrom_seg_23_export                 (rawChromInput[23]),             //   chrom_seg_23.export
        .chrom_seg_24_export                 (rawChromInput[24]),             //   chrom_seg_24.export
        .chrom_seg_25_export                 (rawChromInput[25]),             //   chrom_seg_25.export
        .chrom_seg_26_export                 (rawChromInput[26]),             //   chrom_seg_26.export
        .chrom_seg_27_export                 (rawChromInput[27]),             //   chrom_seg_27.export
        .chrom_seg_28_export                 (rawChromInput[28]),             //   chrom_seg_28.export
        .chrom_seg_29_export                 (rawChromInput[29]),             //   chrom_seg_29.export
        .chrom_seg_30_export                 (rawChromInput[30]),
		  .error_sum_0_export                  (errorSumOutput[0]),
		  .error_sum_1_export                  (errorSumOutput[1]),
		  .error_sum_2_export                  (errorSumOutput[2]),
		  .error_sum_3_export                  (errorSumOutput[3]),
		  .error_sum_4_export                  (errorSumOutput[4]),
		  .error_sum_5_export                  (errorSumOutput[5]),
		  .error_sum_6_export                  (errorSumOutput[6]),
		  .error_sum_7_export                  (errorSumOutput[7]),
		  
		  //Dados seriais
		  .input_sequence_0_export					({ inputSequencesSample[3], inputSequencesSample[2], inputSequencesSample[1], inputSequencesSample[0] }),
		  .expected_output_0_export				({ expectedOutputsSample[3], expectedOutputsSample[2], expectedOutputsSample[1], expectedOutputsSample[0] }),
		  .valid_output_0_export					({validOutputsSample[3], validOutputsSample[2], validOutputsSample[1], validOutputsSample[0] }),
		  .preparingnextsample_export				(preparingNextSample),
		  .writesample_export						(writeSample),
		  .sampleindex_export						(sampleIndex),
		  .nextsample_export							(nextSample),
		  
		  .sequences_to_process_export         (sequencesToProcess),
		  .start_processing_chrom_export       (startProcessingChrom),   // start_processing_chrom.export
        .done_processing_chrom_export        (doneProcessingChrom),     //  done_processing_chrom.export
		  .ready_to_process_export             (readyToProcess),
		  .done_processing_feedback_export     (doneProcessingFeedback),
		  
		  .mem_s2_address                      (memAddress),
		  .mem_s2_chipselect                   (1'b1),
		  .mem_s2_clken                        (1'b1),
		  .mem_s2_write                        (writeToMem),
		  .mem_s2_readdata                     (memReadData),
		  .mem_s2_writedata                    (memWriteData),
		  .mem_s2_byteenable                   (4'b1111),
		  
		  .correct_mem_s2_address              (correctMemAddress),
		  .correct_mem_s2_chipselect           (1'b1),
		  .correct_mem_s2_clken                (1'b1),
		  .correct_mem_s2_write                (writeToCorrectMem),
		  .correct_mem_s2_readdata             (),
		  .correct_mem_s2_writedata            (memReadData),
		  .correct_mem_s2_byteenable           (4'b1111)
		  
    );

//maquina de estados serializacao
ProcessamentoSerial fsm
	( .iClock(CLOCK_50)
	, .iCurrentSerialInput(inputSequencesSample)
	, .iCurrentSerialExpectedOutput(expectedOutputsSample)
	, .iCurrentSerialValidOutput(validOutputsSample)
	, .iSampleIndex(sampleIndex) 
	, .iPreparingNextSample(preparingNextSample)
	, .iWriteSample(writeSample)
	, .oNextSample(nextSample)
	, .oInputSequences(inputSequences)
	, .oExpectedOutputs(expectedOutputs)
	, .oValidOutputs(validOutputs)
	, .verificacao(teste)
	);

	
//VERIFICAÇÃO DE QUANTAS AMOSTRAS SÃO PROCESSADAS	
//Count verificador(
//	.entrada(nextSample),
//	.data(contagem[23:0]) //contagem esta sendo usado como teste para ver os registradores
//);


Decoder7 Dec0 (
	.in(inputSequences[sequenceIDX][3:0]),
	.out(HEX0)
	);

Decoder7 Dec1 (
	.in(inputSequences[sequenceIDX][7:4]),
	.out(HEX1)
	);

Decoder7 Dec2 (
	.in(expectedOutputs[sequenceIDX][3:0]),
	.out(HEX2)
	);

Decoder7 Dec3 (
	.in(expectedOutputs[sequenceIDX][7:4]),
	.out(HEX3)
);

Decoder7 Dec4 (
	.in(sequenceIDX[3:0]),
	.out(HEX4)
);

Decoder7 Dec5 (
	.in(sequenceIDX[7:4]),
	.out(HEX5)
);
	
chromosomeProcessingStateMachine cpsm
	( .iClock(CLOCK_50)
	, .iConcatedChromDescription(concatedChromInput)
	, .iInputSequence(inputSequences)
	, .iExpectedOutput(expectedOutputs)
	, .iValidOutput(validOutputs)
	, .iHardCodedInput(SW[7:0])
	, .iUseHardcodedInput(SW[8])
	, .iUseLastManualInput(SW[9])
	, .iLastRepetitionManualInput(~KEY[0])
	, .iClockChangeCyclesSelector(SW[7:6])
	, .iSequencesToProcess(sequencesToProcess)
	
	// State machine control
	, .iStartProcessing(startProcessingChrom)
	, .iDoneProcessingFeedback(doneProcessingFeedback)
	, .oReadyToProcess(readyToProcess)
	, .oDoneProcessing(doneProcessingChrom)
	
	, .oChromOutput(chromOutput)
	, .oErrorSums(errorSumOutput)
	, .oState(state)
	
	, .oMemContentToWrite(memWriteData)
	, .oMemAddr(memAddress)
	, .oCorrectMemAddr(correctMemAddress)
	, .oWriteToMem(writeToMem)
	, .oWriteToCorrectMem(writeToCorrectMem)
	);
	
	integer sequenceIDX = 0;
	always @(negedge KEY[1] ) begin
		if( sequenceIDX == sequencesToProcess - 1) begin
			sequenceIDX = 0;
		end else begin
			sequenceIDX = sequenceIDX+1;
		end
	
	end
	
	 
endmodule