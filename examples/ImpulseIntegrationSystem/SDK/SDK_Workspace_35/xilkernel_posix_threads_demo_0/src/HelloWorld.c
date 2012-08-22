//////////////////////////////////////////////////////////////////
// Copyright (c) 2003, Impulse Accelerated Technologies, Inc.
// All Rights Reserved.
//
// HelloWorld.c: Tutorial example #1.
//
// Includes cosim (log window) instrumentation.
//

#ifdef WIN32
#include <windows.h>
#endif
#include <stdio.h>
#include "co.h"

extern co_architecture co_initialize(void *);

#define MAX 10
/*
int main(int argc, char *argv[]) {
	int c;
	int iterations = MAX;
	co_architecture my_arch;

	printf("Copyright 2003 Impulse Accelerated Technology, Inc.\n");
	printf("See Application Monitor for transcript messages.\n");
  
	my_arch = co_initialize((void*)iterations);
	co_execute(my_arch);

	printf("Application HelloWorld complete. Press Enter to continue...\n");
	c = getc(stdin);

	return(0);
}
*/
