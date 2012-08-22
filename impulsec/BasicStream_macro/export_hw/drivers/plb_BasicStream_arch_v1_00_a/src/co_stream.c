/*********************************************************************
* Copyright (c) 2003, Impulse Accelerated Technologies, Inc.
* All Rights Reserved.
*
* co_stream.c: Stream functions.
*
* $Id: co_stream.c,v 1.5 2009/03/05 22:00:46 edward.trexel Exp $
*
*********************************************************************/

#include "co.h"
#include "xio.h"

#include <malloc.h>
#include <string.h>

co_stream co_stream_create(char * name, co_type datatype, int buffer_depth)

{
  co_stream stream = malloc(sizeof(co_stream_t));	
  if ( stream != NULL ) {
    stream->name = strdup(name);
    stream->datatype = datatype;
    stream->buffer_depth = buffer_depth;
    stream->direction = CO_NO_DIRECTION;
    stream->io_addr = 0;
  } else print("malloc failed!");
  return stream;
}

void co_stream_attach(co_stream stream, int io_addr, co_stream_direction dir)

{
  stream->io_addr=io_addr;
  stream->direction=dir;
}

int co_stream_close(co_stream stream) 

{
  int data,status;
  if (stream->direction==HW_OUTPUT) {
    /* Throw out data until EOS found*/
    while (1) {
		status=XIo_In32(stream->io_addr+8);
		if (status&0x2) break;
      if (status&0x1) data=XIo_In32((stream)->io_addr);
    }
    /* Read EOS */
    data=XIo_In32((stream)->io_addr);
  } else {
    /* Wait while full. */
    while ((XIo_In32(stream->io_addr+8)&1)==0);
    
    /* Write any value to addr+8 to close. */
    XIo_Out32(stream->io_addr+8,0);
  }

  return(0);
}

int co_stream_read(co_stream stream, void *buffer, int size)

{
  int data,status;

  /* Wait while empty. */
  while (((status=XIo_In32(stream->io_addr+8)&3))==0);
  if ((status&2)!=0) return(co_err_eos);

  data=XIo_In32((stream)->io_addr);
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

  return(0);
}

int co_stream_read_nb(co_stream stream, void *buffer, int size)

{
  int data,status;

  /* Return if empty or EOS. */
  if (((status=XIo_In32(stream->io_addr+8)&3))==0) return 0; 
  if ((status&2)!=0) return 0;

  data=XIo_In32((stream)->io_addr);
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

  return 1;
}

int co_stream_write(co_stream stream, const void *buffer, int size)

{
  int data;

  /* Wait while full. */
  while ((XIo_In32(stream->io_addr+8)&1)==0);

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

  XIo_Out32((stream)->io_addr,data);

  return(0);
}

int co_stream_write_nb(co_stream stream, const void *buffer, int size)

{
  int data;

  /* Return if full. */
  if ((XIo_In32(stream->io_addr+8)&1)==0) return 0;

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

  XIo_Out32((stream)->io_addr,data);

  return 1;
}

