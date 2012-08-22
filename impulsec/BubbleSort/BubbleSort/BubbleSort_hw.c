//**************************************************
//
// File: BubbleSort_hw.c
// Author: Christopher A. Wood, caw4567@rit.edu
// Version: $Id$
//
//**************************************************

#include "co.h"
#include "cosim_log.h"
#include "BubbleSort.h"

// Software process declarations (see BubbleSort_sw.c)
extern void Producer(co_stream input);
extern void Consumer(co_stream output);

//
// This is the hardware process.
// 
void Sorter(co_stream input, co_stream output)
{
	co_int32 nSample = 0;
	co_int32 samples[STREAMDEPTH];
	co_int32 index;
	co_int32 innerIndex;
	co_uint32 NUM_LOOPS = 10000;
	co_int32 counter = 0;

	// Zero out the sample buffer
	for (index = 0; index < STREAMDEPTH; index++)
	{
		samples[index] = 0;
	}
	
	do // Hardware processes run forever
	{	
		// Read values from the stream and store them in a buffer
		index = 0;
		co_stream_open(input, O_RDONLY, INT_TYPE(STREAMWIDTH));
		{
			while (co_stream_read(input, &nSample, sizeof(co_int32)) == co_err_none)
			{
				samples[index++] = nSample;
			}
		}
		co_stream_close(input);
	
		// Sort the data using the bubblesort algorithm
		for (counter = 0; counter < NUM_LOOPS; counter++)
		{
			for (index = 0; index < STREAMDEPTH; index++)
			{
				for (innerIndex = 0; innerIndex < STREAMDEPTH - 1; innerIndex++)
				{
					if (counter % 2 == 0)
					{
						if (samples[innerIndex] > samples[innerIndex + 1])
						{
							nSample = samples[innerIndex + 1];
							samples[innerIndex + 1] = samples[innerIndex];
							samples[innerIndex] = nSample;
						}
					}
					else
					{
						if (samples[innerIndex] < samples[innerIndex + 1])
						{
							nSample = samples[innerIndex + 1];
							samples[innerIndex + 1] = samples[innerIndex];
							samples[innerIndex] = nSample;
						}
					}
				}
			}
		}

		// Write out the sorted values
		co_stream_open(output, O_WRONLY, INT_TYPE(STREAMWIDTH));
		for (index = 0; index < STREAMDEPTH; index++)
		{
			co_stream_write(output, &samples[index], sizeof(co_int32));
		}
		co_stream_close(output);
	} 
	while(1);
}

//
// Impulse C configuration function
//
void config_BubbleSort(void *arg)
{
	co_stream input;
	co_stream output;
	
	co_process Sorter_process;
	co_process producer_process;
	co_process consumer_process;
	
	input = co_stream_create("input", INT_TYPE(STREAMWIDTH), STREAMDEPTH);
	output = co_stream_create("output", INT_TYPE(STREAMWIDTH), STREAMDEPTH);
	
	producer_process = co_process_create("Producer", (co_function)Producer,
										 1,
										 input);
	
	Sorter_process = co_process_create("Sorter", (co_function)Sorter,
									2,
									input,
									output);
	
	consumer_process = co_process_create("Consumer",(co_function)Consumer,
										 1,
										 output);
	
	co_process_config(Sorter_process, co_loc, "pe0");  
}

co_architecture co_initialize(int param)
{
	return(co_architecture_create("BubbleSort_arch","Generic",config_BubbleSort,(void *)param));
}

