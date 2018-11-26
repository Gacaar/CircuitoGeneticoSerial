
module testeio (
	chrom_seg_0_export,
	chrom_seg_1_export,
	chrom_seg_10_export,
	chrom_seg_11_export,
	chrom_seg_12_export,
	chrom_seg_13_export,
	chrom_seg_14_export,
	chrom_seg_15_export,
	chrom_seg_16_export,
	chrom_seg_17_export,
	chrom_seg_18_export,
	chrom_seg_19_export,
	chrom_seg_2_export,
	chrom_seg_20_export,
	chrom_seg_21_export,
	chrom_seg_22_export,
	chrom_seg_23_export,
	chrom_seg_24_export,
	chrom_seg_25_export,
	chrom_seg_26_export,
	chrom_seg_27_export,
	chrom_seg_28_export,
	chrom_seg_29_export,
	chrom_seg_3_export,
	chrom_seg_30_export,
	chrom_seg_4_export,
	chrom_seg_5_export,
	chrom_seg_6_export,
	chrom_seg_7_export,
	chrom_seg_8_export,
	chrom_seg_9_export,
	clk_clk,
	correct_mem_s2_address,
	correct_mem_s2_chipselect,
	correct_mem_s2_clken,
	correct_mem_s2_write,
	correct_mem_s2_readdata,
	correct_mem_s2_writedata,
	correct_mem_s2_byteenable,
	done_processing_chrom_export,
	done_processing_feedback_export,
	error_sum_0_export,
	error_sum_1_export,
	error_sum_2_export,
	error_sum_3_export,
	error_sum_4_export,
	error_sum_5_export,
	error_sum_6_export,
	error_sum_7_export,
	expected_output_0_export,
	expectedoutputs_export,
	hps_io_hps_io_emac1_inst_TX_CLK,
	hps_io_hps_io_emac1_inst_TXD0,
	hps_io_hps_io_emac1_inst_TXD1,
	hps_io_hps_io_emac1_inst_TXD2,
	hps_io_hps_io_emac1_inst_TXD3,
	hps_io_hps_io_emac1_inst_RXD0,
	hps_io_hps_io_emac1_inst_MDIO,
	hps_io_hps_io_emac1_inst_MDC,
	hps_io_hps_io_emac1_inst_RX_CTL,
	hps_io_hps_io_emac1_inst_TX_CTL,
	hps_io_hps_io_emac1_inst_RX_CLK,
	hps_io_hps_io_emac1_inst_RXD1,
	hps_io_hps_io_emac1_inst_RXD2,
	hps_io_hps_io_emac1_inst_RXD3,
	hps_io_hps_io_sdio_inst_CMD,
	hps_io_hps_io_sdio_inst_D0,
	hps_io_hps_io_sdio_inst_D1,
	hps_io_hps_io_sdio_inst_CLK,
	hps_io_hps_io_sdio_inst_D2,
	hps_io_hps_io_sdio_inst_D3,
	hps_io_hps_io_usb1_inst_D0,
	hps_io_hps_io_usb1_inst_D1,
	hps_io_hps_io_usb1_inst_D2,
	hps_io_hps_io_usb1_inst_D3,
	hps_io_hps_io_usb1_inst_D4,
	hps_io_hps_io_usb1_inst_D5,
	hps_io_hps_io_usb1_inst_D6,
	hps_io_hps_io_usb1_inst_D7,
	hps_io_hps_io_usb1_inst_CLK,
	hps_io_hps_io_usb1_inst_STP,
	hps_io_hps_io_usb1_inst_DIR,
	hps_io_hps_io_usb1_inst_NXT,
	hps_io_hps_io_uart0_inst_RX,
	hps_io_hps_io_uart0_inst_TX,
	input_sequence_0_export,
	inputsequences_export,
	mem_s2_address,
	mem_s2_chipselect,
	mem_s2_clken,
	mem_s2_write,
	mem_s2_readdata,
	mem_s2_writedata,
	mem_s2_byteenable,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	nextsample_export,
	preparingnextsample_export,
	ready_to_process_export,
	reset_reset_n,
	sequences_to_process_export,
	start_processing_chrom_export,
	startcomm_export,
	valid_output_0_export,
	validoutputs_export,
	writesample_export);	

	output	[31:0]	chrom_seg_0_export;
	output	[31:0]	chrom_seg_1_export;
	output	[31:0]	chrom_seg_10_export;
	output	[31:0]	chrom_seg_11_export;
	output	[31:0]	chrom_seg_12_export;
	output	[31:0]	chrom_seg_13_export;
	output	[31:0]	chrom_seg_14_export;
	output	[31:0]	chrom_seg_15_export;
	output	[31:0]	chrom_seg_16_export;
	output	[31:0]	chrom_seg_17_export;
	output	[31:0]	chrom_seg_18_export;
	output	[31:0]	chrom_seg_19_export;
	output	[31:0]	chrom_seg_2_export;
	output	[31:0]	chrom_seg_20_export;
	output	[31:0]	chrom_seg_21_export;
	output	[31:0]	chrom_seg_22_export;
	output	[31:0]	chrom_seg_23_export;
	output	[31:0]	chrom_seg_24_export;
	output	[31:0]	chrom_seg_25_export;
	output	[31:0]	chrom_seg_26_export;
	output	[31:0]	chrom_seg_27_export;
	output	[31:0]	chrom_seg_28_export;
	output	[31:0]	chrom_seg_29_export;
	output	[31:0]	chrom_seg_3_export;
	output	[31:0]	chrom_seg_30_export;
	output	[31:0]	chrom_seg_4_export;
	output	[31:0]	chrom_seg_5_export;
	output	[31:0]	chrom_seg_6_export;
	output	[31:0]	chrom_seg_7_export;
	output	[31:0]	chrom_seg_8_export;
	output	[31:0]	chrom_seg_9_export;
	input		clk_clk;
	input	[14:0]	correct_mem_s2_address;
	input		correct_mem_s2_chipselect;
	input		correct_mem_s2_clken;
	input		correct_mem_s2_write;
	output	[31:0]	correct_mem_s2_readdata;
	input	[31:0]	correct_mem_s2_writedata;
	input	[3:0]	correct_mem_s2_byteenable;
	input		done_processing_chrom_export;
	output		done_processing_feedback_export;
	input	[31:0]	error_sum_0_export;
	input	[31:0]	error_sum_1_export;
	input	[31:0]	error_sum_2_export;
	input	[31:0]	error_sum_3_export;
	input	[31:0]	error_sum_4_export;
	input	[31:0]	error_sum_5_export;
	input	[31:0]	error_sum_6_export;
	input	[31:0]	error_sum_7_export;
	output	[31:0]	expected_output_0_export;
	input	[31:0]	expectedoutputs_export;
	output		hps_io_hps_io_emac1_inst_TX_CLK;
	output		hps_io_hps_io_emac1_inst_TXD0;
	output		hps_io_hps_io_emac1_inst_TXD1;
	output		hps_io_hps_io_emac1_inst_TXD2;
	output		hps_io_hps_io_emac1_inst_TXD3;
	input		hps_io_hps_io_emac1_inst_RXD0;
	inout		hps_io_hps_io_emac1_inst_MDIO;
	output		hps_io_hps_io_emac1_inst_MDC;
	input		hps_io_hps_io_emac1_inst_RX_CTL;
	output		hps_io_hps_io_emac1_inst_TX_CTL;
	input		hps_io_hps_io_emac1_inst_RX_CLK;
	input		hps_io_hps_io_emac1_inst_RXD1;
	input		hps_io_hps_io_emac1_inst_RXD2;
	input		hps_io_hps_io_emac1_inst_RXD3;
	inout		hps_io_hps_io_sdio_inst_CMD;
	inout		hps_io_hps_io_sdio_inst_D0;
	inout		hps_io_hps_io_sdio_inst_D1;
	output		hps_io_hps_io_sdio_inst_CLK;
	inout		hps_io_hps_io_sdio_inst_D2;
	inout		hps_io_hps_io_sdio_inst_D3;
	inout		hps_io_hps_io_usb1_inst_D0;
	inout		hps_io_hps_io_usb1_inst_D1;
	inout		hps_io_hps_io_usb1_inst_D2;
	inout		hps_io_hps_io_usb1_inst_D3;
	inout		hps_io_hps_io_usb1_inst_D4;
	inout		hps_io_hps_io_usb1_inst_D5;
	inout		hps_io_hps_io_usb1_inst_D6;
	inout		hps_io_hps_io_usb1_inst_D7;
	input		hps_io_hps_io_usb1_inst_CLK;
	output		hps_io_hps_io_usb1_inst_STP;
	input		hps_io_hps_io_usb1_inst_DIR;
	input		hps_io_hps_io_usb1_inst_NXT;
	input		hps_io_hps_io_uart0_inst_RX;
	output		hps_io_hps_io_uart0_inst_TX;
	output	[31:0]	input_sequence_0_export;
	input	[31:0]	inputsequences_export;
	input	[14:0]	mem_s2_address;
	input		mem_s2_chipselect;
	input		mem_s2_clken;
	input		mem_s2_write;
	output	[31:0]	mem_s2_readdata;
	input	[31:0]	mem_s2_writedata;
	input	[3:0]	mem_s2_byteenable;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
	input	[31:0]	nextsample_export;
	output	[31:0]	preparingnextsample_export;
	input		ready_to_process_export;
	input		reset_reset_n;
	output	[31:0]	sequences_to_process_export;
	output		start_processing_chrom_export;
	output	[31:0]	startcomm_export;
	output	[31:0]	valid_output_0_export;
	input	[31:0]	validoutputs_export;
	output	[31:0]	writesample_export;
endmodule
