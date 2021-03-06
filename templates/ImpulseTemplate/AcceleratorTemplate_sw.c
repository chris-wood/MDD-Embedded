//**************************************************
//
// File: AcceleratorTemplate_sw.c
// Author: Christopher A. Wood, caw4567@rit.edu
// Version: $Id: AcceleratorTemplate_sw.c 46 2012-02-28 15:16:19Z w463-01u3f $
// 
//**************************************************

// Module includes
#include <stdio.h>
#include "co.h"
#include "cosim_log.h"
#include "AcceleratorTemplate.h"

// Externally locatied function prototype
extern co_architecture co_initialize(void *);

/*
 * The producer process that is run on the general purpose CPU.
 *
 * @param HWinput - the FIFO stream used to communicate with the hardware process.
 */
void Producer(co_stream HWinput)
{
	int out = 0;

	// Insert producer pre-streaming logic here.

	co_stream_open(HWinput, O_WRONLY, INT_TYPE(STREAMWIDTH));
	while (1) 
	{
		// Insert producer logic here.
		co_stream_write(HWinput, &out, sizeof(co_int32));
	}
	co_stream_close(HWinput);
	fclose(inFile);
}

/*
 * The consumer process that is run on the general purpose CPU.
 *
 * @param HWinput - the FIFO stream used to communicate with the hardware process.
 */
void Consumer(co_stream HWoutput)
{
	co_int32 in;

	// Insert consumer pre-streaming logic here.

	co_stream_open(HWoutput, O_RDONLY, INT_TYPE(STREAMWIDTH));
	while (co_stream_read(HWoutput, &in, sizeof(co_int32)) == co_err_none) 
	{
		// Insert consumer logic here - in contains a 32-bit signed integer 
		// streamed in from the hardware process.
	}
	co_stream_close(HWoutput);
}

/*
 * The main entry point into the Impulse C function.
 * Note that this is discarded in the integration process (only the
 * co_initialize function invokcation is saved).
 */
int main(int argc, char *argv[])
{
	co_architecture my_arch;
	void *param = NULL;
	int c;

	printf("Impulse C is Copyright(c) 2003-2007 Impulse Accelerated Technologies, Inc.\n");
  
	my_arch = co_initialize(param);
	co_execute(my_arch);

	printf("\n\nApplication complete. Press the Enter key to continue.\n");
	c = getc(stdin);

	return(0);
}


