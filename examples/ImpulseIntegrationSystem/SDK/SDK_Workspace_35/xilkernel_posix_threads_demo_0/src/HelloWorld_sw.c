////////////////////////////////////////////////////////////
// Copyright (c) 2003, Impulse Accelerated Technologies, Inc.
// All Rights Reserved.
//
// HelloWorld_sw.c: Process to be executed on the target CPU.
//

#define MONITOR

#include "co.h"
#include "cosim_log.h"
#include "HelloWorld.h"
#include <stdio.h>

void Producer(co_stream output_stream)
{
	int iterations=1;
	int32 i;
	static char HelloWorldString[] = "Hello World!";
	char *p;

	xil_printf("producer, 123\n");
	co_stream_open(output_stream, O_WRONLY, CHAR_TYPE);

	for(i=0; i<iterations; i++) {
		p = HelloWorldString;

		while (*p) {
			co_stream_write(output_stream, p, sizeof(char));
			p++;
		}
	}
	co_stream_close(output_stream);
  
}

void Consumer(co_stream input_stream)
{
	char c;

	co_stream_open(input_stream, O_RDONLY, CHAR_TYPE);
	xil_printf("consumer, 123\n");

	while ( co_stream_read(input_stream, &c, sizeof(char)) == co_err_none ) {
		xil_printf("Consumer read %c from stream: input_stream\n", c);
	}
	co_stream_close(input_stream);
}
