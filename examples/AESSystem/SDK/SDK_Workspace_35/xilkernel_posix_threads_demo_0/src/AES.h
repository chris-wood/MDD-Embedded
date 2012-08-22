//*************************************************
//
// File: AES.h
// Author: Christopher Wood, caw4567@rit.edu
// Version: $Id$
//
//*************************************************

#ifndef AES_H_
#define AES_H_

#define STREAMDEPTH 177  /* buffer size for FIFO in hardware */
#define STREAMWIDTH 8    /* buffer width for FIFO in hardware */

// AES producer process parameters
typedef struct
{
	co_stream AESdataStream;
	co_signal AESinputSignal;
} AESProducerParam;

// AES consumer process parameters
typedef struct
{
	co_stream AESoutputStream;
} AESConsumerParam;

// External stream declarations
extern co_stream AESdataStream;
extern co_signal AESinputSignal;
extern co_stream AESoutputStream;

// External process declarations
extern void AESProducer(AESProducerParam* param);
extern void AESConsumer(AESConsumerParam* param);

#endif /* AES_H_ */
