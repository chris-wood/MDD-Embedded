//*************************************************
//
// File: ProfileLibrary.h
// Author: Christopher Wood, caw4567@rit.edu
// Version: $Id$
//
//*************************************************

#ifndef PROFILE_LIBRARY_H_
#define PROFILE_LIBRARY_H_

// Module includes
#include "xparameters.h"
#include "xtmrctr.h"

// Macro that initializes a timer with the default address
#define TIMER_INIT(TMR) \
	XTmrCtr_Initialize(&TMR, XPAR_XPS_TIMER_0_DEVICE_ID);

// Macro that expands into start timer counter
#define START_TIME(TIMER, V) \
	XTmrCtr_Reset(&TIMER, 0); \
	XTmrCtr_Start(&TIMER, 0); \
	V = XTmrCtr_GetValue(&TIMER, 0); 

// Macro that expands into end timer counter
#define END_TIME(TIMER, V) \ 
	V = XTmrCtr_GetValue(&TIMER, 0); 

#endif /* PROFILE_LIBRARY_H_ */

