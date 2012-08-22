/*******************************************************************************
 DO NOT EDIT
 This file was automatically generated by the Impulse C Compiler.

 Copyright (c) 2002-2011 by Impulse Accelerated Technologies, Inc.
 All rights reserved.

 This source file may be used and redistributed without charge
 subject to the provisions of the IMPULSE ACCELERATED TECHNOLOGIES,
 INC. REDISTRIBUTABLE IP LICENSE AGREEMENT, and provided that this
 copyright statement is not removed from the file, and that any
 derivative work contains this copyright notice.

 Stage Master is Copyright 2002-2005, Green Mountain Computing Systems, Inc.
 All rights reserved.
 ********************************************************************************/

#include "co.h"

/* Architecture Includes */
#include <stdlib.h>
#include "xio.h"
#include "xparameters.h"
#include "BubbleSort.h"

extern void *alloc_shared( size_t);

/* Run Procedures */
extern void Producer(co_stream);
extern void Sorter(co_stream, co_stream);
extern void Consumer(co_stream);

// Stream declarations
co_stream input1;
co_stream input2;
co_stream input3;
co_stream input4;
co_stream input5;
co_stream output1;
co_stream output2;
co_stream output3;
co_stream output4;
co_stream output5;

// Initialize the process components
co_architecture co_initialize(void *arg)
{
	input1 = co_stream_create("input1", INT_TYPE(32), 32);
	input2 = co_stream_create("input2", INT_TYPE(32), 32);
	input3 = co_stream_create("input3", INT_TYPE(32), 32);
	input4 = co_stream_create("input4", INT_TYPE(32), 32);
	input5 = co_stream_create("input5", INT_TYPE(32), 32);
	output1 = co_stream_create("output1", INT_TYPE(32), 32);
	output2 = co_stream_create("output2", INT_TYPE(32), 32);
	output3 = co_stream_create("output3", INT_TYPE(32), 32);
	output4 = co_stream_create("output4", INT_TYPE(32), 32);
	output5 = co_stream_create("output5", INT_TYPE(32), 32);

	// Create each process
	co_process_create("Producer1", (co_function) Producer, 1, input1);
	co_process_create("Consumer1", (co_function) Consumer, 1, output1);
	co_process_create("Producer2", (co_function) Producer, 1, input2);
	co_process_create("Consumer2", (co_function) Consumer, 1, output2);
	co_process_create("Producer3", (co_function) Producer, 1, input3);
	co_process_create("Consumer3", (co_function) Consumer, 1, output3);
	co_process_create("Producer4", (co_function) Producer, 1, input4);
	co_process_create("Consumer4", (co_function) Consumer, 1, output4);
	co_process_create("Producer5", (co_function) Producer, 1, input5);
	co_process_create("Consumer5", (co_function) Consumer, 1, output5);

	// Architecture Initialization (tie it all together)
	co_stream_attach(input1, XPAR_PLB_BUBBLESORT_ARCH_0_BASEADDR + 0, HW_INPUT);
	co_stream_attach(output1, XPAR_PLB_BUBBLESORT_ARCH_0_BASEADDR + 16,
			HW_OUTPUT);

	co_stream_attach(input2, XPAR_PLB_BUBBLESORT_ARCH_1_BASEADDR + 0, HW_INPUT);
	co_stream_attach(output2, XPAR_PLB_BUBBLESORT_ARCH_1_BASEADDR + 16,
			HW_OUTPUT);

	co_stream_attach(input3, XPAR_PLB_BUBBLESORT_ARCH_2_BASEADDR + 0, HW_INPUT);
	co_stream_attach(output3, XPAR_PLB_BUBBLESORT_ARCH_2_BASEADDR + 16,
			HW_OUTPUT);

	co_stream_attach(input4, XPAR_PLB_BUBBLESORT_ARCH_3_BASEADDR + 0, HW_INPUT);
	co_stream_attach(output4, XPAR_PLB_BUBBLESORT_ARCH_3_BASEADDR + 16,
			HW_OUTPUT);

	co_stream_attach(input5, XPAR_PLB_BUBBLESORT_ARCH_4_BASEADDR + 0, HW_INPUT);
	co_stream_attach(output5, XPAR_PLB_BUBBLESORT_ARCH_4_BASEADDR + 16,
			HW_OUTPUT);

	return(NULL);
}