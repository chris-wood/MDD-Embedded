///////////////////////////////////////////////////////////////////////////////
//
// Generated by Impulse CoDeveloper
// Impulse C is Copyright(c) 2003-2007 Impulse Accelerated Technologies, Inc.
// 
// AES_hw.c: includes the hardware process and configuration
// function.
//
// See additional comments in AES.h.
//

#include "co.h"
#include "cosim_log.h"
#include "AES.h"

const static co_uint8 SBox[256] = {
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

// GL-field multiplication macro
#define xTime(x) ((x<<1) ^ ((x & 0x80) ? 0x1b : 0x00))

// Software process declarations (see AES_sw.c)
extern void Producer(co_signal AESinputSignal, co_stream AESdataStream);
extern void Consumer(co_stream AESoutputStream);

//
// This is the hardware process.
// 
void AESproc(co_signal AESinputSignal, co_stream AESdataStream, co_stream AESoutputStream)
{
	co_uint32 trigger; 
	co_uint32 i, j, k, x;
	co_uint8 streamByte;
	co_uint8 state[4][4];
	co_uint8 stateTemp[4][4];
	co_uint8 expandedKey[11][4][4];
	co_uint32 key[4][4]; 

	// Copy the plaintext into the state array.
	co_signal_wait(AESinputSignal, &trigger);
	co_stream_open(AESdataStream, O_RDONLY, INT_TYPE(STREAMWIDTH));
	i = j = 0;
	while (co_stream_read(AESdataStream, &streamByte, sizeof(co_int8)) == co_err_none) {
		state[i][j++] = streamByte;
		if (j == 4) 
		{
			i++;
			j = 0;
		}
	}
	co_stream_close(AESdataStream);

	// Restore the expanded key.
	co_signal_wait(AESinputSignal, &trigger);
	co_stream_open(AESdataStream, O_RDONLY, INT_TYPE(STREAMWIDTH));
	i = j = k = 0;
	while (co_stream_read(AESdataStream, &streamByte, sizeof(co_int8)) == co_err_none) {
		expandedKey[i][j][k++] = streamByte;
		if (k == 4) 
		{
			j++;
			k = 0; // same as mod to wrap around back to 0
		}
		if (j == 4) 
		{
			i++;
			j = 0; // same as mod to wrap around back to 0
		}
	}
	co_stream_close(AESdataStream);

	// Save the first block in the expanded key as the original key.
	for (i = 0; i < 4; i++)
	{
		for (j = 0; j < 4; j++)
		{
			key[i][j] = expandedKey[0][i][j];
		}
	}
	
	/* Inline AES encryption starts here */
	co_signal_wait(AESinputSignal, 0);

	// AddRoundKey
	for (i = 0; i < 4; i++) {
		for (j = 0; j < 4; j++) {
			state[i][j] ^= key[i][j];
		}
	}

	for (j = 1; j <= 10; j++)
	{
		// SubBytes and ShiftRows
		// Row #0 - simple substitute w/ values from S-box
		state[0][0] = SBox[state[0][0]];
		state[0][1] = SBox[state[0][1]];
		state[0][2] = SBox[state[0][2]];
		state[0][3] = SBox[state[0][3]];
	  
		// Row#1 - substitute and rotate 1 column to the left
		x = SBox[state[1][0]];
		state[1][0] = SBox[state[1][1]];
		state[1][1] = SBox[state[1][2]];
		state[1][2] = SBox[state[1][3]];
		state[1][3] = x;

		// Row#2 - substitute and rotate 2 columns to the left
		x = SBox[state[2][0]];
		state[2][0] = SBox[state[2][2]];
		state[2][2] = x;
		x = SBox[state[2][1]];
		state[2][1] = SBox[state[2][3]];
		state[2][3] = x;

		// Row#3 - substitute and rotate 3 columns to the left
		x = SBox[state[3][3]];
		state[3][3] = SBox[state[3][2]];
		state[3][2] = SBox[state[3][1]];
		state[3][1] = SBox[state[3][0]];
		state[3][0] = x;

		if (j != 10)
		{
			// mixcolumns
			for (i = 0; i <4; i++) 
			{
				stateTemp[0][i] = xTime(state[0][i])^xTime(state[1][i])^state[1][i]^
					state[2][i]^state[3][i];
				stateTemp[1][i] = state[0][i]^xTime(state[1][i])^
					xTime(state[2][i])^state[2][i]^state[3][i];
				stateTemp[2][i] = state[0][i]^state[1][i]^
					xTime(state[2][i])^xTime(state[3][i])^state[3][i];
				stateTemp[3][i] = xTime(state[0][i])^state[0][i]^state[1][i]^
					state[2][i]^xTime(state[3][i]);
			}

			// Overwrite the state array with the mixed column data
			for (i = 0; i < 4; i++)
			{
				for (k = 0; k < 4; k++) 
				{
					state[i][k] = stateTemp[i][k];
				}
			}
		}

		// AddRoundKey
		for (i = 0; i < 4; i++) {
			for (k = 0; k < 4; k++) {
				state[i][k] ^= expandedKey[j][i][k];
			}
		}
	}

	// Write some data to the output stream.
	co_stream_open(AESoutputStream, O_WRONLY, INT_TYPE(STREAMWIDTH));
	for (i = 0; i < 4; i++) 
	{
		for (j = 0; j < 4; j++)
		{
			co_stream_write(AESoutputStream, &state[i][j], sizeof(co_int8));
		}
	}
	co_stream_close(AESoutputStream);
}

//
// Impulse C configuration function
//
void config_AES(void *arg)
{
	co_stream AESdataStream;
	co_stream AESoutputStream;
	co_signal AESinputSignal;
	
	co_process AESproc_process;
	co_process producer_process;
	co_process consumer_process;
	
	AESinputSignal = co_signal_create("AESinputSignal");
	AESdataStream = co_stream_create("AESdataStream", INT_TYPE(STREAMWIDTH), STREAMDEPTH);
	AESoutputStream = co_stream_create("AESoutputStream", INT_TYPE(STREAMWIDTH), STREAMDEPTH);
	
	producer_process = co_process_create(
		"Producer",
		(co_function)Producer,
		2,
		AESinputSignal,
		AESdataStream
	);
	
	AESproc_process = co_process_create(
		"AESproc",
		(co_function)AESproc,
		3,
		AESinputSignal,
		AESdataStream,
		AESoutputStream
	);
	
	consumer_process = co_process_create(
		"Consumer",
		(co_function)Consumer,
		1,
		AESoutputStream
	);
	
	// Assign the hardware process to run on the FPGA
	co_process_config(AESproc_process, co_loc, "pe0");
}

co_architecture co_initialize(int param)
{
	return(co_architecture_create("AES_arch","Generic",config_AES,(void *)param));
}
