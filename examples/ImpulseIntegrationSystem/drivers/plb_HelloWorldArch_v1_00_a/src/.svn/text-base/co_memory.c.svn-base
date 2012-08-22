/*********************************************************************
* Copyright (c) 2003, Impulse Accelerated Technologies, Inc.
* All Rights Reserved.
*
* $Id: co_memory.c,v 1.2 2004/12/03 17:07:25 CVSUSER Exp $
*
* co_memory.c: Functions for creating, reading, and writing memories.
*
* Change History
* --------------
* 05/27/2004 - Scott Thibault
*   File created.
*
*********************************************************************/

#include <malloc.h>
#include <string.h>

#include "co.h"


co_memory co_memory_create(char *name, char *loc, unsigned int size, void *(*alloc)(size_t))
{
  co_memory m;

	m = (co_memory) malloc(sizeof(co_memory_t));
	if (m != NULL) {
	  m->name = (name != NULL) ? strdup(name) : NULL;
	  m->data = (*alloc)(size);
	  if (m->data == NULL)
	    print("co_memory alloc failed!");
	  m->size = size;
	} else print("malloc failed!");
	return(m);
}

co_error co_memory_readblock(co_memory m, unsigned int offset, void *buf, unsigned int bufsize)
{
	if ( (offset + bufsize) > m->size ) {
		return(co_err_invalid_arg);
	}

	memcpy(buf, ((char *) m->data) +offset, bufsize);
	
	return(co_err_none);
}

co_error co_memory_writeblock(co_memory m, unsigned int offset, void *buf, unsigned int bufsize)
{
	if ( (offset + bufsize) > m->size ) {
		return(co_err_invalid_arg);
	}

	memcpy(((char *) m->data) + offset, buf, bufsize);

	return(co_err_none);
}

void *co_memory_ptr(co_memory m)

{
       return m->data;
}

