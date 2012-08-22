// ///////////////////////////////////////////////////////////
// Copyright (c) 2003, Impulse Accelerated Technologies, Inc.
// All Rights Reserved.
//
// HelloWorld_hw.c: Hardware processes and configuration code.
//

#ifdef WIN32
#include <windows.h>
#endif
#include <stdio.h>
#include "co.h"

#define MONITOR

#ifdef MONITOR
#include "cosim_log.h"
#endif

// Software processes defined in HelloWorld_sw.c
extern void Consumer(co_stream input_stream);
extern void Producer(co_stream output_stream, co_parameter iparam);

//////////////////////////////////////////////
// Hardware process
//
void DoText(co_stream input_stream, co_stream output_stream)
{
	char c;

	IF_SIM(cosim_logwindow log;)
	IF_SIM(log = cosim_logwindow_create("DoText");)	

	do {
		IF_SIM(cosim_logwindow_write(log, "Process DoText opening stream: input_stream\n");)
		co_stream_open(input_stream, O_RDONLY, CHAR_TYPE);
		IF_SIM(cosim_logwindow_write(log, "Process DoText opening stream: output_stream\n");)
		co_stream_open(output_stream, O_WRONLY, CHAR_TYPE);

		while ( co_stream_read(input_stream, &c, sizeof(char)) == co_err_none ) {
			IF_SIM(cosim_logwindow_fwrite(log, "Process DoText read %c from stream: input_stream\n", c);)
			IF_SIM(printf("Process DoText read %c from stream: input_stream\n", c );)

			// At this point we could do something with the data stream
			co_stream_write(output_stream,&c,sizeof(char));
		}

		co_stream_close(input_stream);
		co_stream_close(output_stream);

		IF_SIM(break;)	// Only run the process once for simulation.
						// In hardware it should run forever.
	} while (1);
}

//
// Configuration function
//
#define BUFSIZE 2
void config_helloworld(void *arg)
{
	int iterations = (int) arg;
	co_stream s1,s2;
	co_process producer, consumer;
	co_process dotext;

	IF_SIM( cosim_logwindow_init(); )

	s1=co_stream_create("Stream1",CHAR_TYPE,BUFSIZE);
	s2=co_stream_create("Stream2",CHAR_TYPE,BUFSIZE);

	producer=co_process_create("Producer",(co_function) Producer, 2, s1, iterations);
	dotext=co_process_create("DoText",(co_function) DoText, 2, s1, s2);
	consumer=co_process_create("Consumer",(co_function) Consumer, 1, s2);

	co_process_config(dotext, co_loc, "PE0");  // Assign DoText to a hardware element
}

co_architecture co_initialize(int iterations)
{
	return(co_architecture_create("HelloWorldArch","generic",config_helloworld,(void *)iterations));
}
