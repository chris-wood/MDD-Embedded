//**************************************************
//
// File: BubbleSort_sw.c
// Author: Christopher A. Wood, caw4567@rit.edu
// Version: $Id$
//
//**************************************************

#include <stdio.h>
#include "co.h"
#include "BubbleSort.h"

extern co_architecture co_initialize(void *);

void Producer(co_stream input)
{
	co_int32 index = 0;

	// Write the data in backwards to get the worst case complexity
	co_stream_open(input, O_WRONLY, INT_TYPE(STREAMWIDTH));
	{
		for (index = STREAMDEPTH; index >= 0; index--)
		{
			co_stream_write(input, &index, sizeof(co_int32));
		}
	}
	co_stream_close(input);
}

void Consumer(co_stream output)
{
	co_int32 value = 0;

	co_stream_open(output, O_RDONLY, INT_TYPE(STREAMWIDTH));

	// Continuously read data from the stream
	while (1)
	{
		while ( co_stream_read(output, &value, sizeof(co_int32)) == co_err_none ) 
		{
			printf("   -> 0x%x\n", value);
		}
	}
	co_stream_close(output);
}

int main(int argc, char *argv[])
{
	co_architecture my_arch;
	void *param = NULL;
	int c;
  
	printf("Starting...\n");

	my_arch = co_initialize(param);
	co_execute(my_arch);

	printf("\n\nApplication complete. Press the Enter key to continue.\n");
	c = getc(stdin);

	return(0);
}


