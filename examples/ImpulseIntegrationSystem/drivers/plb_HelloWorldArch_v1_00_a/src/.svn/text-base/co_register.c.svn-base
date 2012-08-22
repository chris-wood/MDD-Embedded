/*********************************************************************
* Copyright (c) 2003, Impulse Accelerated Technologies, Inc.
* All Rights Reserved.
*
* co_register.c: register functions.
*
* $Id: co_register.c,v 1.2 2004/12/03 17:07:26 CVSUSER Exp $
*
*********************************************************************/

#include "co.h"
#include "xio.h"

#include <malloc.h>
#include <string.h>

co_register co_register_create(const char * name, co_type type)
{
	co_register reg = malloc(sizeof(co_register_t));	
	if ( reg != NULL ) {
		reg->name = strdup(name);
		reg->direction = CO_NO_DIRECTION;
		reg->io_addr = 0;
	} else print("malloc failed!");
	return reg;
}

void co_register_attach(co_register reg, int io_addr, co_stream_direction dir)
{
    if ( reg != NULL ) {
	reg->io_addr = io_addr;
    	reg->direction = dir;
    }
}

int32 co_register_get(co_register reg)
{
  return(XIo_In32(reg->io_addr));
}

void co_register_put(co_register reg, int32 value)
{
  XIo_Out32(reg->io_addr,value);
}

co_error co_register_read(co_register reg, void *buffer, unsigned int size)
{
  int data;

  data=XIo_In32(reg->io_addr);
  switch (size) {
  case 1:
    *(char *)buffer=data;
    break;
  case 2:
    *(short *)buffer=data;
    break;
  default: 
    *(int *)buffer=data;
    break;
  }

  return(co_err_none);
}

co_error co_register_write(co_register reg, const void *buffer, unsigned int size)
{
  int data;

  switch (size) {
  case 1:
    data=*(char *)buffer;
    break;
  case 2:
    data=*(short *)buffer;
    break;
  default: 
    data=*(int *)buffer;
    break;
  }

  XIo_Out32(reg->io_addr,data);

  return(co_err_none);
}

