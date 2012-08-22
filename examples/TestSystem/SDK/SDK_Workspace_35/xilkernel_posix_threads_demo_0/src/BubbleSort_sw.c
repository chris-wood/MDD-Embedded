//*************************************************
//
// File: BubbleSort_sw.c
// Author: Christopher Wood, caw4567@rit.edu
// Version: $Id$
//
//*************************************************
#include <stdio.h>
#include "co.h"
#include "cosim_log.h"
#include "BubbleSort.h"

// External initialization declaration
extern co_architecture co_initialize(void *);

// Software producer process declaration
void Producer(co_stream input)
{
	co_int32 index = 0;

	// Write the data in backwards to get the worst case complexity
	co_stream_open(input, O_WRONLY, INT_TYPE(BUBBLESTREAMDEPTH));
	{
		for (index = BUBBLESTREAMDEPTH; index >= 0; index--)
		{
			co_stream_write(input, &index, sizeof(co_int32));
		}
	}
	co_stream_close(input);
}

// Software consumer process declaration
void Consumer(co_stream output)
{
	co_int32 value = 0;
	co_int32 count = 0;

	co_stream_open(output, O_RDONLY, INT_TYPE(BUBBLESTREAMDEPTH));

	// Continuously read data from the stream
	while (count < BUBBLESTREAMDEPTH)
	{
		while (co_stream_read(output, &value, sizeof(co_int32)) == co_err_none )
		{
			count++;
			xil_printf("   -> 0x%x\n", value);
		}
	}
	co_stream_close(output);
}


