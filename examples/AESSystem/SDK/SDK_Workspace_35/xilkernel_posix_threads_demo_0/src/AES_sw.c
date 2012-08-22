//*************************************************
//
// File: AES_sw.c
// Author: Christopher Wood, caw4567@rit.edu
// Version: $Id$
//
//*************************************************

#include <stdio.h>
#include "co.h"
#include "cosim_log.h"
#include "AES.h"

extern co_architecture co_initialize(void *);

// AES Rcon
const unsigned char RCon[10] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36};

// The S-box
const co_uint8 SubBox[256] = {
 // 0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F
 0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,   //0
 0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,   //1
 0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,   //2
 0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,   //3
 0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,   //4
 0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,   //5
 0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,   //6
 0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,   //7
 0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,   //8
 0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,   //9
 0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,   //A
 0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,   //B
 0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,   //C
 0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,   //D
 0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,   //E
 0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16 }; //F

//
// This is the software data producer for the hardware AES process.
// It will signal the hardware process when it has initialized all
// of the data the encryption engine needs to operate.
//
void AESProducer(AESProducerParam* param)
{
	co_signal AESinputSignal = param->AESinputSignal;
	co_stream AESdataStream = param->AESdataStream;

	co_uint32 i, j, k;
	co_uint8 tempKey[4][4];
	co_uint8 tempKeyCol[4];
	co_uint8 expandedKey[11][4][4];

	// Create the key and plaintext for use by the AES engine.
	uint8 key[4][4] = { { 0x2b, 0x28, 0xab, 0x09 },
						{ 0x7e, 0xae, 0xf7, 0xcf },
						{ 0x15, 0xd2, 0x15, 0x4f },
						{ 0x16, 0xa6, 0x88, 0x3c } };

	uint8 plainText[4][4] = { {0x32, 0x88, 0x31, 0xe0}, 
	                          {0x43, 0x5a, 0x31, 0x37}, 
	                          {0xf6, 0x30, 0x98, 0x07}, 
	                          {0xa8, 0x8d, 0xa2, 0x34} };

	// Expand the key into the key schedule using an inline version of ExpandKey.
	memset(tempKey, 0, 4 * 4 * sizeof(uint8));
	memset(tempKeyCol, 0, 4 * sizeof(uint8));
	memset(expandedKey, 0, 11 * 4 * 4 * sizeof(uint8));

	// Copy the encryption key to ExpandedKey[0].
	memcpy(expandedKey[0], key, 4 * 4 * sizeof(uint8));

	// TODO: start timer

	// Create the expanded key.
	for (i = 1; i < 11; i++)
	{
		// Rotate the column.
		tempKeyCol[0] = expandedKey[i - 1][1][3];
		tempKeyCol[1] = expandedKey[i - 1][2][3];
		tempKeyCol[2] = expandedKey[i - 1][3][3];
		tempKeyCol[3] = expandedKey[i - 1][0][3];

		// Replace the bytes with vlaues from the s-box.
		tempKeyCol[0] = SubBox[tempKeyCol[0]];
		tempKeyCol[1] = SubBox[tempKeyCol[1]];
		tempKeyCol[2] = SubBox[tempKeyCol[2]];
		tempKeyCol[3] = SubBox[tempKeyCol[3]];

		// Apply the rcon.
		tempKeyCol[0] ^= RCon[i - 1];

		// XOR operation.
		for (j = 0; j < 4; j++)
		{
			tempKeyCol[0] = tempKeyCol[0] ^ expandedKey[i - 1][0][j];
			tempKeyCol[1] = tempKeyCol[1] ^ expandedKey[i - 1][1][j];
			tempKeyCol[2] = tempKeyCol[2] ^ expandedKey[i - 1][2][j];
			tempKeyCol[3] = tempKeyCol[3] ^ expandedKey[i - 1][3][j];

			// Set the new column data in the expanded key.
			expandedKey[i][0][j] = tempKeyCol[0];
			expandedKey[i][1][j] = tempKeyCol[1];
			expandedKey[i][2][j] = tempKeyCol[2];
			expandedKey[i][3][j] = tempKeyCol[3];
		}
	}

	// Display the contents of the expanded key
	xil_printf("ExpandKey routine complete.\n");
	xil_printf("\nDisplaying expandedKey contents:\n");
	for (i = 0; i < 11; i++)
	{
		xil_printf("Block %d\n", i);
		for (j = 0; j < 4; j++)
		{
			xil_printf("[%x, %x, %x, %x]\n", expandedKey[i][j][0],
				expandedKey[i][j][1], expandedKey[i][j][2], expandedKey[i][j][3]);
		}
		xil_printf("\n");
	}

	// Send the plaintext to the output stream so it can be used by the hardware process.
	co_stream_open(AESdataStream, O_WRONLY, INT_TYPE(STREAMWIDTH));
	xil_printf("Sending plaintext to AES data stream.\n");
	for (i = 0; i < 4; i++)
	{
		for (j = 0; j < 4; j++)
		{
			xil_printf("  -> 0x%x\n", plainText[i][j]);
			co_stream_write(AESdataStream, &plainText[i][j], sizeof(co_uint8));
		}
	}
	co_stream_close(AESdataStream);
	co_signal_post(AESinputSignal, 0);
	xil_printf("Plaintext copy complete.\n\n");

	// Send the expanded key to the HW process using a stream.
	co_stream_open(AESdataStream, O_WRONLY, INT_TYPE(STREAMWIDTH));
	xil_printf("Sending expanded key to AES input stream.\n");
	for (i = 0; i < 11; i++)
	{
		for (j = 0; j < 4; j++) 
		{
			for (k = 0; k < 4; k++)
			{
				xil_printf("  -> 0x%x\n", expandedKey[i][j][k]);
				co_stream_write(AESdataStream, &expandedKey[i][j][k], sizeof(co_uint8));
			}
		}
	}
	co_stream_close(AESdataStream);
	co_signal_post(AESinputSignal, 0);
	xil_printf("Expanded key copy complete.\n\n");

	// Signal that expand key is complete and allow the AES engine to start processing the data.
	xil_printf("Signaling hardware process to begin.\n\n");
	co_signal_post(AESinputSignal, 0);
}

//
// This is the Consumer process that reads ciphertext from 
// the hardware process to display.
//
void AESConsumer(AESConsumerParam* param)
{
	co_stream AESoutputStream = param->AESoutputStream;
	co_uint8 streamValue;
	
	co_stream_open(AESoutputStream, O_RDONLY, INT_TYPE(STREAMWIDTH));
	xil_printf("Consumer reading data.\n");
	while ( co_stream_read(AESoutputStream, &streamValue, sizeof(co_int8)) == co_err_none ) {
		xil_printf("  -> 0x%x\n", streamValue);
	}
	co_stream_close(AESoutputStream);
}
