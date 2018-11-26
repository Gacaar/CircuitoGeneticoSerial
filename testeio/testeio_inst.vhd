	component testeio is
		port (
			chrom_seg_0_export              : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_1_export              : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_10_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_11_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_12_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_13_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_14_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_15_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_16_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_17_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_18_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_19_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_2_export              : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_20_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_21_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_22_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_23_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_24_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_25_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_26_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_27_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_28_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_29_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_3_export              : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_30_export             : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_4_export              : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_5_export              : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_6_export              : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_7_export              : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_8_export              : out   std_logic_vector(31 downto 0);                    -- export
			chrom_seg_9_export              : out   std_logic_vector(31 downto 0);                    -- export
			clk_clk                         : in    std_logic                     := 'X';             -- clk
			correct_mem_s2_address          : in    std_logic_vector(14 downto 0) := (others => 'X'); -- address
			correct_mem_s2_chipselect       : in    std_logic                     := 'X';             -- chipselect
			correct_mem_s2_clken            : in    std_logic                     := 'X';             -- clken
			correct_mem_s2_write            : in    std_logic                     := 'X';             -- write
			correct_mem_s2_readdata         : out   std_logic_vector(31 downto 0);                    -- readdata
			correct_mem_s2_writedata        : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			correct_mem_s2_byteenable       : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			done_processing_chrom_export    : in    std_logic                     := 'X';             -- export
			done_processing_feedback_export : out   std_logic;                                        -- export
			error_sum_0_export              : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			error_sum_1_export              : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			error_sum_2_export              : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			error_sum_3_export              : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			error_sum_4_export              : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			error_sum_5_export              : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			error_sum_6_export              : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			error_sum_7_export              : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			expected_output_0_export        : out   std_logic_vector(31 downto 0);                    -- export
			expectedoutputs_export          : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			hps_io_hps_io_emac1_inst_TX_CLK : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
			hps_io_hps_io_emac1_inst_TXD0   : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
			hps_io_hps_io_emac1_inst_TXD1   : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
			hps_io_hps_io_emac1_inst_TXD2   : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
			hps_io_hps_io_emac1_inst_TXD3   : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
			hps_io_hps_io_emac1_inst_RXD0   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
			hps_io_hps_io_emac1_inst_MDIO   : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
			hps_io_hps_io_emac1_inst_MDC    : out   std_logic;                                        -- hps_io_emac1_inst_MDC
			hps_io_hps_io_emac1_inst_RX_CTL : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
			hps_io_hps_io_emac1_inst_TX_CTL : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
			hps_io_hps_io_emac1_inst_RX_CLK : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
			hps_io_hps_io_emac1_inst_RXD1   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
			hps_io_hps_io_emac1_inst_RXD2   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
			hps_io_hps_io_emac1_inst_RXD3   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
			hps_io_hps_io_sdio_inst_CMD     : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
			hps_io_hps_io_sdio_inst_D0      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
			hps_io_hps_io_sdio_inst_D1      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
			hps_io_hps_io_sdio_inst_CLK     : out   std_logic;                                        -- hps_io_sdio_inst_CLK
			hps_io_hps_io_sdio_inst_D2      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
			hps_io_hps_io_sdio_inst_D3      : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
			hps_io_hps_io_usb1_inst_D0      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
			hps_io_hps_io_usb1_inst_D1      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
			hps_io_hps_io_usb1_inst_D2      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
			hps_io_hps_io_usb1_inst_D3      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
			hps_io_hps_io_usb1_inst_D4      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
			hps_io_hps_io_usb1_inst_D5      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
			hps_io_hps_io_usb1_inst_D6      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
			hps_io_hps_io_usb1_inst_D7      : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
			hps_io_hps_io_usb1_inst_CLK     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
			hps_io_hps_io_usb1_inst_STP     : out   std_logic;                                        -- hps_io_usb1_inst_STP
			hps_io_hps_io_usb1_inst_DIR     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
			hps_io_hps_io_usb1_inst_NXT     : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
			hps_io_hps_io_uart0_inst_RX     : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
			hps_io_hps_io_uart0_inst_TX     : out   std_logic;                                        -- hps_io_uart0_inst_TX
			input_sequence_0_export         : out   std_logic_vector(31 downto 0);                    -- export
			inputsequences_export           : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			mem_s2_address                  : in    std_logic_vector(14 downto 0) := (others => 'X'); -- address
			mem_s2_chipselect               : in    std_logic                     := 'X';             -- chipselect
			mem_s2_clken                    : in    std_logic                     := 'X';             -- clken
			mem_s2_write                    : in    std_logic                     := 'X';             -- write
			mem_s2_readdata                 : out   std_logic_vector(31 downto 0);                    -- readdata
			mem_s2_writedata                : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			mem_s2_byteenable               : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			memory_mem_a                    : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba                   : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                   : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n                 : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke                  : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n                 : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n                : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n                : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n                 : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n              : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                   : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs                  : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n                : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                  : out   std_logic;                                        -- mem_odt
			memory_mem_dm                   : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin                : in    std_logic                     := 'X';             -- oct_rzqin
			nextsample_export               : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			preparingnextsample_export      : out   std_logic_vector(31 downto 0);                    -- export
			ready_to_process_export         : in    std_logic                     := 'X';             -- export
			reset_reset_n                   : in    std_logic                     := 'X';             -- reset_n
			sequences_to_process_export     : out   std_logic_vector(31 downto 0);                    -- export
			start_processing_chrom_export   : out   std_logic;                                        -- export
			startcomm_export                : out   std_logic_vector(31 downto 0);                    -- export
			valid_output_0_export           : out   std_logic_vector(31 downto 0);                    -- export
			validoutputs_export             : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			writesample_export              : out   std_logic_vector(31 downto 0)                     -- export
		);
	end component testeio;

	u0 : component testeio
		port map (
			chrom_seg_0_export              => CONNECTED_TO_chrom_seg_0_export,              --              chrom_seg_0.export
			chrom_seg_1_export              => CONNECTED_TO_chrom_seg_1_export,              --              chrom_seg_1.export
			chrom_seg_10_export             => CONNECTED_TO_chrom_seg_10_export,             --             chrom_seg_10.export
			chrom_seg_11_export             => CONNECTED_TO_chrom_seg_11_export,             --             chrom_seg_11.export
			chrom_seg_12_export             => CONNECTED_TO_chrom_seg_12_export,             --             chrom_seg_12.export
			chrom_seg_13_export             => CONNECTED_TO_chrom_seg_13_export,             --             chrom_seg_13.export
			chrom_seg_14_export             => CONNECTED_TO_chrom_seg_14_export,             --             chrom_seg_14.export
			chrom_seg_15_export             => CONNECTED_TO_chrom_seg_15_export,             --             chrom_seg_15.export
			chrom_seg_16_export             => CONNECTED_TO_chrom_seg_16_export,             --             chrom_seg_16.export
			chrom_seg_17_export             => CONNECTED_TO_chrom_seg_17_export,             --             chrom_seg_17.export
			chrom_seg_18_export             => CONNECTED_TO_chrom_seg_18_export,             --             chrom_seg_18.export
			chrom_seg_19_export             => CONNECTED_TO_chrom_seg_19_export,             --             chrom_seg_19.export
			chrom_seg_2_export              => CONNECTED_TO_chrom_seg_2_export,              --              chrom_seg_2.export
			chrom_seg_20_export             => CONNECTED_TO_chrom_seg_20_export,             --             chrom_seg_20.export
			chrom_seg_21_export             => CONNECTED_TO_chrom_seg_21_export,             --             chrom_seg_21.export
			chrom_seg_22_export             => CONNECTED_TO_chrom_seg_22_export,             --             chrom_seg_22.export
			chrom_seg_23_export             => CONNECTED_TO_chrom_seg_23_export,             --             chrom_seg_23.export
			chrom_seg_24_export             => CONNECTED_TO_chrom_seg_24_export,             --             chrom_seg_24.export
			chrom_seg_25_export             => CONNECTED_TO_chrom_seg_25_export,             --             chrom_seg_25.export
			chrom_seg_26_export             => CONNECTED_TO_chrom_seg_26_export,             --             chrom_seg_26.export
			chrom_seg_27_export             => CONNECTED_TO_chrom_seg_27_export,             --             chrom_seg_27.export
			chrom_seg_28_export             => CONNECTED_TO_chrom_seg_28_export,             --             chrom_seg_28.export
			chrom_seg_29_export             => CONNECTED_TO_chrom_seg_29_export,             --             chrom_seg_29.export
			chrom_seg_3_export              => CONNECTED_TO_chrom_seg_3_export,              --              chrom_seg_3.export
			chrom_seg_30_export             => CONNECTED_TO_chrom_seg_30_export,             --             chrom_seg_30.export
			chrom_seg_4_export              => CONNECTED_TO_chrom_seg_4_export,              --              chrom_seg_4.export
			chrom_seg_5_export              => CONNECTED_TO_chrom_seg_5_export,              --              chrom_seg_5.export
			chrom_seg_6_export              => CONNECTED_TO_chrom_seg_6_export,              --              chrom_seg_6.export
			chrom_seg_7_export              => CONNECTED_TO_chrom_seg_7_export,              --              chrom_seg_7.export
			chrom_seg_8_export              => CONNECTED_TO_chrom_seg_8_export,              --              chrom_seg_8.export
			chrom_seg_9_export              => CONNECTED_TO_chrom_seg_9_export,              --              chrom_seg_9.export
			clk_clk                         => CONNECTED_TO_clk_clk,                         --                      clk.clk
			correct_mem_s2_address          => CONNECTED_TO_correct_mem_s2_address,          --           correct_mem_s2.address
			correct_mem_s2_chipselect       => CONNECTED_TO_correct_mem_s2_chipselect,       --                         .chipselect
			correct_mem_s2_clken            => CONNECTED_TO_correct_mem_s2_clken,            --                         .clken
			correct_mem_s2_write            => CONNECTED_TO_correct_mem_s2_write,            --                         .write
			correct_mem_s2_readdata         => CONNECTED_TO_correct_mem_s2_readdata,         --                         .readdata
			correct_mem_s2_writedata        => CONNECTED_TO_correct_mem_s2_writedata,        --                         .writedata
			correct_mem_s2_byteenable       => CONNECTED_TO_correct_mem_s2_byteenable,       --                         .byteenable
			done_processing_chrom_export    => CONNECTED_TO_done_processing_chrom_export,    --    done_processing_chrom.export
			done_processing_feedback_export => CONNECTED_TO_done_processing_feedback_export, -- done_processing_feedback.export
			error_sum_0_export              => CONNECTED_TO_error_sum_0_export,              --              error_sum_0.export
			error_sum_1_export              => CONNECTED_TO_error_sum_1_export,              --              error_sum_1.export
			error_sum_2_export              => CONNECTED_TO_error_sum_2_export,              --              error_sum_2.export
			error_sum_3_export              => CONNECTED_TO_error_sum_3_export,              --              error_sum_3.export
			error_sum_4_export              => CONNECTED_TO_error_sum_4_export,              --              error_sum_4.export
			error_sum_5_export              => CONNECTED_TO_error_sum_5_export,              --              error_sum_5.export
			error_sum_6_export              => CONNECTED_TO_error_sum_6_export,              --              error_sum_6.export
			error_sum_7_export              => CONNECTED_TO_error_sum_7_export,              --              error_sum_7.export
			expected_output_0_export        => CONNECTED_TO_expected_output_0_export,        --        expected_output_0.export
			expectedoutputs_export          => CONNECTED_TO_expectedoutputs_export,          --          expectedoutputs.export
			hps_io_hps_io_emac1_inst_TX_CLK => CONNECTED_TO_hps_io_hps_io_emac1_inst_TX_CLK, --                   hps_io.hps_io_emac1_inst_TX_CLK
			hps_io_hps_io_emac1_inst_TXD0   => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD0,   --                         .hps_io_emac1_inst_TXD0
			hps_io_hps_io_emac1_inst_TXD1   => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD1,   --                         .hps_io_emac1_inst_TXD1
			hps_io_hps_io_emac1_inst_TXD2   => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD2,   --                         .hps_io_emac1_inst_TXD2
			hps_io_hps_io_emac1_inst_TXD3   => CONNECTED_TO_hps_io_hps_io_emac1_inst_TXD3,   --                         .hps_io_emac1_inst_TXD3
			hps_io_hps_io_emac1_inst_RXD0   => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD0,   --                         .hps_io_emac1_inst_RXD0
			hps_io_hps_io_emac1_inst_MDIO   => CONNECTED_TO_hps_io_hps_io_emac1_inst_MDIO,   --                         .hps_io_emac1_inst_MDIO
			hps_io_hps_io_emac1_inst_MDC    => CONNECTED_TO_hps_io_hps_io_emac1_inst_MDC,    --                         .hps_io_emac1_inst_MDC
			hps_io_hps_io_emac1_inst_RX_CTL => CONNECTED_TO_hps_io_hps_io_emac1_inst_RX_CTL, --                         .hps_io_emac1_inst_RX_CTL
			hps_io_hps_io_emac1_inst_TX_CTL => CONNECTED_TO_hps_io_hps_io_emac1_inst_TX_CTL, --                         .hps_io_emac1_inst_TX_CTL
			hps_io_hps_io_emac1_inst_RX_CLK => CONNECTED_TO_hps_io_hps_io_emac1_inst_RX_CLK, --                         .hps_io_emac1_inst_RX_CLK
			hps_io_hps_io_emac1_inst_RXD1   => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD1,   --                         .hps_io_emac1_inst_RXD1
			hps_io_hps_io_emac1_inst_RXD2   => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD2,   --                         .hps_io_emac1_inst_RXD2
			hps_io_hps_io_emac1_inst_RXD3   => CONNECTED_TO_hps_io_hps_io_emac1_inst_RXD3,   --                         .hps_io_emac1_inst_RXD3
			hps_io_hps_io_sdio_inst_CMD     => CONNECTED_TO_hps_io_hps_io_sdio_inst_CMD,     --                         .hps_io_sdio_inst_CMD
			hps_io_hps_io_sdio_inst_D0      => CONNECTED_TO_hps_io_hps_io_sdio_inst_D0,      --                         .hps_io_sdio_inst_D0
			hps_io_hps_io_sdio_inst_D1      => CONNECTED_TO_hps_io_hps_io_sdio_inst_D1,      --                         .hps_io_sdio_inst_D1
			hps_io_hps_io_sdio_inst_CLK     => CONNECTED_TO_hps_io_hps_io_sdio_inst_CLK,     --                         .hps_io_sdio_inst_CLK
			hps_io_hps_io_sdio_inst_D2      => CONNECTED_TO_hps_io_hps_io_sdio_inst_D2,      --                         .hps_io_sdio_inst_D2
			hps_io_hps_io_sdio_inst_D3      => CONNECTED_TO_hps_io_hps_io_sdio_inst_D3,      --                         .hps_io_sdio_inst_D3
			hps_io_hps_io_usb1_inst_D0      => CONNECTED_TO_hps_io_hps_io_usb1_inst_D0,      --                         .hps_io_usb1_inst_D0
			hps_io_hps_io_usb1_inst_D1      => CONNECTED_TO_hps_io_hps_io_usb1_inst_D1,      --                         .hps_io_usb1_inst_D1
			hps_io_hps_io_usb1_inst_D2      => CONNECTED_TO_hps_io_hps_io_usb1_inst_D2,      --                         .hps_io_usb1_inst_D2
			hps_io_hps_io_usb1_inst_D3      => CONNECTED_TO_hps_io_hps_io_usb1_inst_D3,      --                         .hps_io_usb1_inst_D3
			hps_io_hps_io_usb1_inst_D4      => CONNECTED_TO_hps_io_hps_io_usb1_inst_D4,      --                         .hps_io_usb1_inst_D4
			hps_io_hps_io_usb1_inst_D5      => CONNECTED_TO_hps_io_hps_io_usb1_inst_D5,      --                         .hps_io_usb1_inst_D5
			hps_io_hps_io_usb1_inst_D6      => CONNECTED_TO_hps_io_hps_io_usb1_inst_D6,      --                         .hps_io_usb1_inst_D6
			hps_io_hps_io_usb1_inst_D7      => CONNECTED_TO_hps_io_hps_io_usb1_inst_D7,      --                         .hps_io_usb1_inst_D7
			hps_io_hps_io_usb1_inst_CLK     => CONNECTED_TO_hps_io_hps_io_usb1_inst_CLK,     --                         .hps_io_usb1_inst_CLK
			hps_io_hps_io_usb1_inst_STP     => CONNECTED_TO_hps_io_hps_io_usb1_inst_STP,     --                         .hps_io_usb1_inst_STP
			hps_io_hps_io_usb1_inst_DIR     => CONNECTED_TO_hps_io_hps_io_usb1_inst_DIR,     --                         .hps_io_usb1_inst_DIR
			hps_io_hps_io_usb1_inst_NXT     => CONNECTED_TO_hps_io_hps_io_usb1_inst_NXT,     --                         .hps_io_usb1_inst_NXT
			hps_io_hps_io_uart0_inst_RX     => CONNECTED_TO_hps_io_hps_io_uart0_inst_RX,     --                         .hps_io_uart0_inst_RX
			hps_io_hps_io_uart0_inst_TX     => CONNECTED_TO_hps_io_hps_io_uart0_inst_TX,     --                         .hps_io_uart0_inst_TX
			input_sequence_0_export         => CONNECTED_TO_input_sequence_0_export,         --         input_sequence_0.export
			inputsequences_export           => CONNECTED_TO_inputsequences_export,           --           inputsequences.export
			mem_s2_address                  => CONNECTED_TO_mem_s2_address,                  --                   mem_s2.address
			mem_s2_chipselect               => CONNECTED_TO_mem_s2_chipselect,               --                         .chipselect
			mem_s2_clken                    => CONNECTED_TO_mem_s2_clken,                    --                         .clken
			mem_s2_write                    => CONNECTED_TO_mem_s2_write,                    --                         .write
			mem_s2_readdata                 => CONNECTED_TO_mem_s2_readdata,                 --                         .readdata
			mem_s2_writedata                => CONNECTED_TO_mem_s2_writedata,                --                         .writedata
			mem_s2_byteenable               => CONNECTED_TO_mem_s2_byteenable,               --                         .byteenable
			memory_mem_a                    => CONNECTED_TO_memory_mem_a,                    --                   memory.mem_a
			memory_mem_ba                   => CONNECTED_TO_memory_mem_ba,                   --                         .mem_ba
			memory_mem_ck                   => CONNECTED_TO_memory_mem_ck,                   --                         .mem_ck
			memory_mem_ck_n                 => CONNECTED_TO_memory_mem_ck_n,                 --                         .mem_ck_n
			memory_mem_cke                  => CONNECTED_TO_memory_mem_cke,                  --                         .mem_cke
			memory_mem_cs_n                 => CONNECTED_TO_memory_mem_cs_n,                 --                         .mem_cs_n
			memory_mem_ras_n                => CONNECTED_TO_memory_mem_ras_n,                --                         .mem_ras_n
			memory_mem_cas_n                => CONNECTED_TO_memory_mem_cas_n,                --                         .mem_cas_n
			memory_mem_we_n                 => CONNECTED_TO_memory_mem_we_n,                 --                         .mem_we_n
			memory_mem_reset_n              => CONNECTED_TO_memory_mem_reset_n,              --                         .mem_reset_n
			memory_mem_dq                   => CONNECTED_TO_memory_mem_dq,                   --                         .mem_dq
			memory_mem_dqs                  => CONNECTED_TO_memory_mem_dqs,                  --                         .mem_dqs
			memory_mem_dqs_n                => CONNECTED_TO_memory_mem_dqs_n,                --                         .mem_dqs_n
			memory_mem_odt                  => CONNECTED_TO_memory_mem_odt,                  --                         .mem_odt
			memory_mem_dm                   => CONNECTED_TO_memory_mem_dm,                   --                         .mem_dm
			memory_oct_rzqin                => CONNECTED_TO_memory_oct_rzqin,                --                         .oct_rzqin
			nextsample_export               => CONNECTED_TO_nextsample_export,               --               nextsample.export
			preparingnextsample_export      => CONNECTED_TO_preparingnextsample_export,      --      preparingnextsample.export
			ready_to_process_export         => CONNECTED_TO_ready_to_process_export,         --         ready_to_process.export
			reset_reset_n                   => CONNECTED_TO_reset_reset_n,                   --                    reset.reset_n
			sequences_to_process_export     => CONNECTED_TO_sequences_to_process_export,     --     sequences_to_process.export
			start_processing_chrom_export   => CONNECTED_TO_start_processing_chrom_export,   --   start_processing_chrom.export
			startcomm_export                => CONNECTED_TO_startcomm_export,                --                startcomm.export
			valid_output_0_export           => CONNECTED_TO_valid_output_0_export,           --           valid_output_0.export
			validoutputs_export             => CONNECTED_TO_validoutputs_export,             --             validoutputs.export
			writesample_export              => CONNECTED_TO_writesample_export               --              writesample.export
		);

