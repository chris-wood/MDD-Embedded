//**************************************************
//
// File: AcceleratorTemplate_hw.c
// Author: Christopher A. Wood, caw4567@rit.edu
// Version: $Id: AcceleratorTemplate_hw.c 46 2012-02-28 15:16:19Z w463-01u3f $
// 
//**************************************************

#include "co.h"
#include "cosim_log.h"
#include "AcceleratorTemplate.h"

// Software process declarations (see AcceleratorTemplate_sw.c)
extern void Producer(co_stream HWinput);
extern void Consumer(co_stream HWoutput);

/*
 * The hardware process that represents our accelerator.
 *
 * @param HWinput - the input FIFO used to stream in data to use in the computation.
 * @param HWoutput - the output FIFO used to stream out computed results.
 */
void Accelerator(co_stream HWinput, co_stream HWoutput)
{
	co_int32 nSample;
	
	do 	
	{	// Hardware processes run forever
		co_stream_open(HWinput, O_RDONLY, INT_TYPE(STREAMWIDTH));
		co_stream_open(HWoutput, O_WRONLY, INT_TYPE(STREAMWIDTH));
	
		// Read values from the stream
		while (co_stream_read(HWinput, &nSample, sizeof(co_int32)) == co_err_none) {
		#pragma CO PIPELINE
	
			// One sample is now in variable nSample.
			// Add acceleration logic here.
	
			co_stream_write(HWoutput, &nSample, sizeof(co_int32));
		}
		co_stream_close(HWinput);
		co_stream_close(HWoutput);
	} 
	while(1);
}

/*
 * Impulse C configuration function - only modify if process names or parameters are changed.
 */
void config_AcceleratorTemplate(void *arg)
{
	co_stream HWinput;
	co_stream HWoutput;
	
	co_process Accelerator_process;
	co_process producer_process;
	co_process consumer_process;

	IF_SIM(cosim_logwindow_init();)
	
	HWinput = co_stream_create("HWinput", INT_TYPE(STREAMWIDTH), STREAMDEPTH);
	HWoutput = co_stream_create("HWoutput", INT_TYPE(STREAMWIDTH), STREAMDEPTH);
	
	producer_process = co_process_create("Producer", (co_function)Producer,
										 1,
										 HWinput);
	
	Accelerator_process = co_process_create("Accelerator", (co_function)Accelerator,
									2,
									HWinput,
									HWoutput);
	
	consumer_process = co_process_create("Consumer",(co_function)Consumer,
										 1,
										 HWoutput);
	
	co_process_config(Accelerator_process, co_loc, "pe0");  
}

co_architecture co_initialize(int param)
{
	return(co_architecture_create("AcceleratorTemplate_arch","Generic",config_AcceleratorTemplate,(void *)param));
}

