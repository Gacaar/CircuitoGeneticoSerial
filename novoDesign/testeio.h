#ifndef _ALTERA_TESTEIO_H_
#define _ALTERA_TESTEIO_H_

/*
 * This file was automatically generated by the swinfo2header utility.
 * 
 * Created from SOPC Builder system 'testeio' in
 * file './testeio.sopcinfo'.
 */

/*
 * This file contains macros for module 'hps_0' and devices
 * connected to the following masters:
 *   h2f_axi_master
 *   h2f_lw_axi_master
 * 
 * Do not include this header file and another header file created for a
 * different module or master group at the same time.
 * Doing so may result in duplicate macro names.
 * Instead, use the system header file which has macros with unique names.
 */

/*
 * Macros for device 'SWs_pio', class 'altera_avalon_pio'
 * The macros are prefixed with 'SWS_PIO_'.
 * The prefix is the slave descriptor.
 */
#define SWS_PIO_COMPONENT_TYPE altera_avalon_pio
#define SWS_PIO_COMPONENT_NAME SWs_pio
#define SWS_PIO_BASE 0x0
#define SWS_PIO_SPAN 16
#define SWS_PIO_END 0xf
#define SWS_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define SWS_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SWS_PIO_CAPTURE 0
#define SWS_PIO_DATA_WIDTH 10
#define SWS_PIO_DO_TEST_BENCH_WIRING 0
#define SWS_PIO_DRIVEN_SIM_VALUE 0
#define SWS_PIO_EDGE_TYPE NONE
#define SWS_PIO_FREQ 50000000
#define SWS_PIO_HAS_IN 1
#define SWS_PIO_HAS_OUT 0
#define SWS_PIO_HAS_TRI 0
#define SWS_PIO_IRQ_TYPE NONE
#define SWS_PIO_RESET_VALUE 0

/*
 * Macros for device 'LEDs_pio', class 'altera_avalon_pio'
 * The macros are prefixed with 'LEDS_PIO_'.
 * The prefix is the slave descriptor.
 */
#define LEDS_PIO_COMPONENT_TYPE altera_avalon_pio
#define LEDS_PIO_COMPONENT_NAME LEDs_pio
#define LEDS_PIO_BASE 0x10
#define LEDS_PIO_SPAN 16
#define LEDS_PIO_END 0x1f
#define LEDS_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define LEDS_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LEDS_PIO_CAPTURE 0
#define LEDS_PIO_DATA_WIDTH 10
#define LEDS_PIO_DO_TEST_BENCH_WIRING 0
#define LEDS_PIO_DRIVEN_SIM_VALUE 0
#define LEDS_PIO_EDGE_TYPE NONE
#define LEDS_PIO_FREQ 50000000
#define LEDS_PIO_HAS_IN 0
#define LEDS_PIO_HAS_OUT 1
#define LEDS_PIO_HAS_TRI 0
#define LEDS_PIO_IRQ_TYPE NONE
#define LEDS_PIO_RESET_VALUE 1023


#endif /* _ALTERA_TESTEIO_H_ */