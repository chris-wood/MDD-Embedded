//*************************************************
//
// File: BubbleSort.h
// Author: Christopher Wood, caw4567@rit.edu
// Version: $Id$
//
//*************************************************

#define BUBBLESTREAMDEPTH 32	/* buffer size for FIFO in hardware */
#define BUBBLESTREAMWIDTH 32	    /* buffer width for FIFO in hardware */

// External process declarations
extern void Producer(co_stream input);
extern void Consumer(co_stream output);

// External stream declarations
extern co_stream input1;
extern co_stream input2;
extern co_stream input3;
extern co_stream input4;
extern co_stream input5;
extern co_stream output1;
extern co_stream output2;
extern co_stream output3;
extern co_stream output4;
extern co_stream output5;
