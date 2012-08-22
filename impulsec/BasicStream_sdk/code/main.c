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

// IMPULSE C ADDED
#include "co.h"
#include "cosim_log.h"
#include "BasicStream.h"

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
    co_architecture my_arch;
    void *param = NULL;
    int c;

    xil_printf("init_platform()\n");
    init_platform(); // be careful with this call here...
    
    printf("Impulse C is Copyright(c) 2003-2007 Impulse Accelerated Technologies, Inc.\n");
	printf("--------------------------------------------------------------------------\n");
	printf("Basic Stream: Producer -----> HW process -----> Consumer\n\n");

	// Note: added to configure the Impulse C projects
	my_arch = co_initialize(param);

	printf("\n\nApplication complete. Press the Enter key to continue.\n");
	c = getc(stdin);

    /* Assign random data to the input array */
    
    for (i = 0; i < DATA_SIZE; i++)
        input_data[i] = i + 1;

    xil_printf("here we go!\n");

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
    pthread_t worker[N_THREADS];
    pthread_attr_t attr;
    pthread_t pid;
    pthread_t cid;

    /* This is how we can join with a thread and reclaim its return value */
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

    // Create the Impulse C threads
    pthread_create(&pid, NULL, (void*)Producer, HWinput);
    pthread_create(&cid, NULL, (void*)Consumer, HWoutput);

    pthread_join(pid, NULL);
    pthread_join(cid, NULL);

    xil_printf("Xilkernel Demo: Master Thread Completing.\r\n");
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
