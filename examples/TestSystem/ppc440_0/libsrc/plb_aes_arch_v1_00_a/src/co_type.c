/*********************************************************************
* Copyright (c) 2003, Impulse Accelerated Technologies, Inc.
* All Rights Reserved.
*
* co_type.c: Datatype functions.
*
* $Id: co_type.c,v 1.2 2004/12/03 17:07:27 CVSUSER Exp $
*
*********************************************************************/

#include "co.h"

co_type co_type_create(co_sort sort, unsigned int width)
{
	co_type type = (co_type) malloc(sizeof(co_type_t));
	if ( type != NULL ) {
  		type->sort = sort;
  		type->width = width;
  	} else print("malloc failed!");
  	return type;
}
