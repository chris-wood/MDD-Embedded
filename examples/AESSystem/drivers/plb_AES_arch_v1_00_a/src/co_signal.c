/*********************************************************************
* Copyright (c) 2003, Impulse Accelerated Technologies, Inc.
* All Rights Reserved.
*
* co_signal.c: Signal functions.
*
* $Id: co_signal.c,v 1.2 2004/12/03 17:07:26 CVSUSER Exp $
*
*********************************************************************/

#include "co.h"
#include "xio.h"

#include <malloc.h>
#include <string.h>

co_signal co_signal_create(char * name)
{
	co_signal signal = malloc(sizeof(co_signal_t));	
	if ( signal != NULL ) {
		signal->name = strdup(name);
		signal->direction = CO_NO_DIRECTION;
		signal->io_addr = 0;
	} else print("malloc failed!");
	return signal;
}

void co_signal_attach(co_signal signal, int io_addr, co_stream_direction dir)

{
  signal->io_addr=io_addr;
  signal->direction=dir;
}

co_error co_signal_wait(co_signal signal, int32 *vp)

{
  /* Wait while empty. */
  while ((XIo_In32(signal->io_addr+8)&1)==0);

  *vp=XIo_In32((signal)->io_addr);

  return(co_err_none);
}

co_error co_signal_post(co_signal signal, int32 value)

{
  XIo_Out32((signal)->io_addr,value);

  return(co_err_none);
}

