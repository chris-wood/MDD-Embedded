////////////////////////////////////////////////////////////
// Copyright (c) 2003, Impulse Accelerated Technologies, Inc.
// All Rights Reserved.
//
// HelloWorld_sw.c: Process to be executed on the target CPU.
//

#define MONITOR

#include "co.h"
#include "cosim_log.h"
#include <stdio.h>

void Producer(co_stream output_stream, co_parameter iparam)
{
	int iterations=(int)iparam;
	int32 i;
	static char HelloWorldString[] = "Hello World!";
	char *p;

	cosim_logwindow log;
	log = cosim_logwindow_create("Producer");
	cosim_logwindow_fwrite(log, "Process Producer entered, iterations = %d\n", iterations);
  
	cosim_logwindow_write(log, "Process Producer opening stream: output_stream\n");
	co_stream_open(output_stream, O_WRONLY, CHAR_TYPE);
 
	for(i=0; i<iterations; i++) {
		p = HelloWorldString;

		while (*p) {
			cosim_logwindow_fwrite(log, "Process Producer writing stream: output_stream with: %c\n", *p);
			co_stream_write(output_stream, p, sizeof(char));
			p++;
		}
	}
	cosim_logwindow_write(log, "Process Producer closing stream output_stream\n");
	co_stream_close(output_stream);
  
	cosim_logwindow_write(log, "Process Producer exiting\n");
}

void Consumer(co_stream input_stream)
{
	char c;

	cosim_logwindow log;
	log = cosim_logwindow_create("Consumer");
	cosim_logwindow_write(log, "Process Consumer entered\n");

	cosim_logwindow_write(log, "Process Consumer opening stream: input_stream\n");
	co_stream_open(input_stream, O_RDONLY, CHAR_TYPE);

	cosim_logwindow_write(log, "Process Consumer reading stream: input_stream\n");
	while ( co_stream_read(input_stream, &c, sizeof(char)) == co_err_none ) {
		cosim_logwindow_fwrite(log, "Process Consumer read %c from stream: input_stream\n", c);
		printf("Consumer read %c from stream: input_stream\n", c);
	}
	cosim_logwindow_fwrite(log, "Process Consumer closing stream input_stream\n");
	co_stream_close(input_stream);

	cosim_logwindow_fwrite(log, "Process Consumer exiting\n");
}
