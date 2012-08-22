/*
 * Copyright (c) 2009 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/* Includes */
#include "xmk.h"
#include "os_config.h"
#include "sys/ksched.h"
#include "sys/init.h"
#include "config/config_param.h"
#include "stdio.h"
#include "xparameters.h"
#include "platform.h"
#include "platform_config.h"
#include <pthread.h>
#include <sys/types.h>
#include "xtmrctr.h"

#include "co.h"
#include "BubbleSort.h"
#include "ProfileLibrary.h"

/* Declarations */
#define DATA_SIZE   400
#define N_THREADS   4

void* master_thread(void *);
void* partial_sum_worker(void *);

/* Data */
int input_data[DATA_SIZE];


/* Functions */
int main()
{
    int i;

    init_platform();
    
    /* Assign random data to the input array */
    
    for (i = 0; i < DATA_SIZE; i++)
        input_data[i] = i + 1;

    /* Initialize xilkernel */
    xilkernel_init();

    /* Create the master thread */
    xmk_add_static_thread(master_thread, 0);
    
    /* Start the kernel */
    xilkernel_start();
    
    /* Never reached */
    cleanup_platform();
    
    return 0;
}

/* The master thread */
void* master_thread(void *arg)
{
	co_architecture my_arch;
	void *param = NULL;

	XTmrCtr timer;
	uint32 startCycles;
	uint32 endCycles;

    pthread_t pid1;
    pthread_t pid2;
    pthread_t pid3;
    pthread_t pid4;
    pthread_t cid1;
    pthread_t cid2;
    pthread_t cid3;
    pthread_t cid4;

	// Create the architecture
    my_arch = co_initialize(param);

    // Kick it off
    xil_printf("Starting BubbleSort.\r\n");
    TIMER_INIT(timer);
    START_TIME(timer, startCycles);

    /* Insert code for the threads here */
    pthread_create(&pid1, NULL, (void*)Producer, input1);
    pthread_create(&cid1, NULL, (void*)Consumer, output1);
    pthread_create(&pid2, NULL, (void*)Producer, input2);
	pthread_create(&cid2, NULL, (void*)Consumer, output2);
	pthread_create(&pid3, NULL, (void*)Producer, input3);
	pthread_create(&cid3, NULL, (void*)Consumer, output3);
	pthread_create(&pid4, NULL, (void*)Producer, input4);
	pthread_create(&cid4, NULL, (void*)Consumer, output4);

    /* Join on the threads before they exit */
    pthread_join(pid1, NULL);
    pthread_join(cid1, NULL);
    pthread_join(pid2, NULL);
    pthread_join(cid2, NULL);
    pthread_join(pid3, NULL);
    pthread_join(cid3, NULL);
    pthread_join(pid4, NULL);
    pthread_join(cid4, NULL);

    END_TIME(timer, endCycles);
    xil_printf("Total time: %10d\n", endCycles - startCycles);

    xil_printf("Ending BubbleSort.\r\n");
    return (void*)0;
}

/* The worker thread */
void* partial_sum_worker(void *arg)
{
    int i, psum;
    int my_id = *((int*)arg);
    int subarray_len = (DATA_SIZE / N_THREADS);
    int start = my_id * subarray_len;
    int end = start + subarray_len;

    psum = 0;
    for (i = start; i < end; i++) 
        psum += input_data[i];

    /* This is how return a value to the parent */
    pthread_exit((void*)psum);
    return NULL;
}
