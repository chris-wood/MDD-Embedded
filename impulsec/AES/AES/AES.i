# 1 "<stdin>"
# 1 "<built-in>"
# 1 "<command line>"
# 12 "<command line>"
# 1 "AES_hw.c" 1
# 12 "AES_hw.c"
# 1 "C:/Impulse/CoDeveloper3/Include/co.h" 1
# 27 "C:/Impulse/CoDeveloper3/Include/co.h"
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/fcntl.h" 1 3
# 34 "C:/Impulse/CoDeveloper3/MinGW/include/fcntl.h" 3
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/_mingw.h" 1 3
# 35 "C:/Impulse/CoDeveloper3/MinGW/include/fcntl.h" 2 3




# 1 "C:/Impulse/CoDeveloper3/MinGW/include/io.h" 1 3
# 36 "C:/Impulse/CoDeveloper3/MinGW/include/io.h" 3
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/stdio.h" 1 3
# 37 "C:/Impulse/CoDeveloper3/MinGW/include/io.h" 2 3






# 1 "C:/Impulse/CoDeveloper3/MinGW/include/sys/types.h" 1 3
# 44 "C:/Impulse/CoDeveloper3/MinGW/include/io.h" 2 3
# 40 "C:/Impulse/CoDeveloper3/MinGW/include/fcntl.h" 2 3
# 28 "C:/Impulse/CoDeveloper3/Include/co.h" 2
# 1 "C:/Impulse/CoDeveloper3/Include/co_types.h" 1
# 18 "C:/Impulse/CoDeveloper3/Include/co_types.h"
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/windows.h" 1 3
# 17 "C:/Impulse/CoDeveloper3/MinGW/include/windows.h" 3
# 44 "C:/Impulse/CoDeveloper3/MinGW/include/windows.h" 3
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/winresrc.h" 1 3
# 5 "C:/Impulse/CoDeveloper3/MinGW/include/winresrc.h" 3



# 1 "C:/Impulse/CoDeveloper3/MinGW/include/winuser.h" 1 3
# 5 "C:/Impulse/CoDeveloper3/MinGW/include/winuser.h" 3
# 9 "C:/Impulse/CoDeveloper3/MinGW/include/winresrc.h" 2 3
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/winnt.h" 1 3
# 5 "C:/Impulse/CoDeveloper3/MinGW/include/winnt.h" 3
# 34 "C:/Impulse/CoDeveloper3/MinGW/include/winnt.h" 3
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/winerror.h" 1 3
# 5 "C:/Impulse/CoDeveloper3/MinGW/include/winerror.h" 3
# 35 "C:/Impulse/CoDeveloper3/MinGW/include/winnt.h" 2 3
# 158 "C:/Impulse/CoDeveloper3/MinGW/include/winnt.h" 3
typedef unsigned char FCHAR;
typedef unsigned short FSHORT;
typedef unsigned int FLONG;


# 1 "C:/Impulse/CoDeveloper3/MinGW/include/basetsd.h" 1 3
# 5 "C:/Impulse/CoDeveloper3/MinGW/include/basetsd.h" 3
# 164 "C:/Impulse/CoDeveloper3/MinGW/include/winnt.h" 2 3
# 10 "C:/Impulse/CoDeveloper3/MinGW/include/winresrc.h" 2 3
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/winver.h" 1 3
# 5 "C:/Impulse/CoDeveloper3/MinGW/include/winver.h" 3
# 11 "C:/Impulse/CoDeveloper3/MinGW/include/winresrc.h" 2 3
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/dde.h" 1 3
# 5 "C:/Impulse/CoDeveloper3/MinGW/include/dde.h" 3
# 12 "C:/Impulse/CoDeveloper3/MinGW/include/winresrc.h" 2 3
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/dlgs.h" 1 3
# 5 "C:/Impulse/CoDeveloper3/MinGW/include/dlgs.h" 3
# 13 "C:/Impulse/CoDeveloper3/MinGW/include/winresrc.h" 2 3
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/commctrl.h" 1 3
# 5 "C:/Impulse/CoDeveloper3/MinGW/include/commctrl.h" 3


# 1 "C:/Impulse/CoDeveloper3/MinGW/include/prsht.h" 1 3
# 5 "C:/Impulse/CoDeveloper3/MinGW/include/prsht.h" 3
# 8 "C:/Impulse/CoDeveloper3/MinGW/include/commctrl.h" 2 3
# 14 "C:/Impulse/CoDeveloper3/MinGW/include/winresrc.h" 2 3
# 45 "C:/Impulse/CoDeveloper3/MinGW/include/windows.h" 2 3
# 19 "C:/Impulse/CoDeveloper3/Include/co_types.h" 2






typedef enum {co_err_none = 0, co_err_eos, co_err_invalid_arg, co_err_already_open, co_err_not_open, co_err_unavail, co_err_unknown} co_error;

typedef char int8;
typedef unsigned char uint8;
typedef short int16;
typedef unsigned short uint16;
typedef int int32;
typedef unsigned int uint32;




typedef long long int64;
typedef unsigned long long uint64;


typedef enum {co_int_sort = 1, co_uint_sort, co_float_sort} co_sort;

struct co_type_s;
typedef struct co_type_s *co_type;

typedef enum {co_loc, co_kind, co_banks, co_alignment} co_attribute;

struct co_arch_s;
typedef struct co_arch_s *co_architecture;

typedef void *co_parameter;

typedef void (*co_function)();
typedef void (*co_config_function)(void *);

struct co_process_s;
typedef struct co_process_s *co_process;

struct co_memory_s;
typedef struct co_memory_s *co_memory;

struct co_signal_s;
typedef struct co_signal_s *co_signal;

struct co_register_s;
typedef struct co_register_s *co_register;

struct co_semaphore_s;
typedef struct co_semaphore_s *co_semaphore;

typedef void *co_port;
typedef enum {co_input=0, co_output} co_port_mode;

struct co_input_wire_s;
typedef struct co_input_wire_s *co_input_wire;

struct co_output_wire_s;
typedef struct co_output_wire_s *co_output_wire;
# 92 "C:/Impulse/CoDeveloper3/Include/co_types.h"
typedef struct co_stream_s {
        char *name;
        unsigned int flags;
        co_type type;

        unsigned int impl_size;
        unsigned int size;
        union {
                uint8 *fifo8;
                uint16 *fifo16;
                uint32 *fifo32;
                uint64 *fifo64;
        } u;
        uint8 *storage, *in_pos, *end, *drain;
        uint8 *ctrl_storage, *ctrl_in_pos, *ctrl_fifo, *ctrl_end;
        unsigned int fill_count;
        unsigned int reader,writer;
        void *rgate,*wgate;
        void *mutex;
        void *waveform;





} co_stream_t;
typedef struct co_stream_s *co_stream;
# 29 "C:/Impulse/CoDeveloper3/Include/co.h" 2
# 1 "C:/Impulse/CoDeveloper3/Include/co_import.h" 1
# 30 "C:/Impulse/CoDeveloper3/Include/co.h" 2




extern co_architecture co_architecture_create(const char *name, const char *arch, co_config_function configure, void *arg);
extern co_process co_process_create(const char *name, co_function run, int argc, ...);
extern co_error co_process_config(co_process process, co_attribute attribute, const char *value);
extern co_error co_array_config(void * buffer, co_attribute attribute, const char * value);
extern void co_execute(co_architecture architecture);



extern co_type co_type_create(co_sort sort, unsigned int width);
# 63 "C:/Impulse/CoDeveloper3/Include/co.h"
extern co_stream co_stream_create(const char *name, co_type type, int numelements);
extern co_error co_stream_config(co_stream stream, co_attribute attribute, const char *val);
extern co_error co_stream_open(co_stream stream, int mode, co_type type);
extern co_error co_stream_close(co_stream stream);
extern co_error co_stream_read(co_stream stream, void *buffer, long unsigned int buffersize);
extern int co_stream_read_nb(co_stream stream, void *buffer, long unsigned int buffersize);
extern co_error co_stream_write(co_stream stream, const void *buffer, long unsigned int buffersize);
extern int co_stream_write_nb(co_stream stream, const void *buffer, long unsigned int buffersize);
extern int co_stream_eos(co_stream stream);
extern co_error co_stream_free(co_stream stream);
# 96 "C:/Impulse/CoDeveloper3/Include/co.h"
extern co_signal co_signal_create(const char *name);
extern co_signal co_signal_create_ex(const char *name, co_type type);
extern co_error co_signal_wait(co_signal signal, int32 *ip);
extern co_error co_signal_post(co_signal signal, int32 value);
extern co_error co_signal_free(co_signal signal);



extern co_register co_register_create(const char *name, co_type type);
extern co_error co_register_write(co_register reg, const void *buffer, long unsigned int buffersize);
extern co_error co_register_read(co_register reg, void *buffer, long unsigned int buffersize);
extern void co_register_put(co_register reg, int32 value);
extern int32 co_register_get(co_register reg);
extern co_error co_register_free(co_register reg);


extern co_semaphore co_semaphore_create(const char *name, int init, int max);
extern co_error co_semaphore_wait(co_semaphore sema);
extern co_error co_semaphore_release(co_semaphore sema);
extern co_error co_semaphore_free(co_semaphore sema);



extern co_memory co_memory_create(const char *name, const char *loc, long unsigned int size);
extern void co_memory_writeblock(co_memory mem, unsigned int offset, void *buf, long unsigned int buffersize);
extern void co_memory_readblock(co_memory mem, unsigned int offset, void *buf, long unsigned int buffersize);
extern void *co_memory_ptr(co_memory mem);
extern co_error co_memory_free(co_memory mem);
extern void co_memory_set(co_memory m, void* buf, long unsigned int bufsize);
# 133 "C:/Impulse/CoDeveloper3/Include/co.h"
extern co_input_wire co_input_wire_create(const char *name, co_type type);
extern co_output_wire co_output_wire_create(const char *name, co_type type);



extern co_port co_port_create(const char *name, co_port_mode mode, void *io_object);


# 1 "C:/Impulse/CoDeveloper3/Include/co_if_sim.h" 1
# 142 "C:/Impulse/CoDeveloper3/Include/co.h" 2


# 1 "C:/Impulse/CoDeveloper3/Include/co_math.h" 1
# 24 "C:/Impulse/CoDeveloper3/Include/co_math.h"
typedef int8 co_int1;
typedef int8 co_int2;
typedef int8 co_int3;
typedef int8 co_int4;
typedef int8 co_int5;
typedef int8 co_int6;
typedef int8 co_int7;
typedef int8 co_int8;
typedef int16 co_int9;
typedef int16 co_int10;
typedef int16 co_int11;
typedef int16 co_int12;
typedef int16 co_int13;
typedef int16 co_int14;
typedef int16 co_int15;
typedef int16 co_int16;
typedef int32 co_int17;
typedef int32 co_int18;
typedef int32 co_int19;
typedef int32 co_int20;
typedef int32 co_int21;
typedef int32 co_int22;
typedef int32 co_int23;
typedef int32 co_int24;
typedef int32 co_int25;
typedef int32 co_int26;
typedef int32 co_int27;
typedef int32 co_int28;
typedef int32 co_int29;
typedef int32 co_int30;
typedef int32 co_int31;
typedef int32 co_int32;
typedef int64 co_int33;
typedef int64 co_int34;
typedef int64 co_int35;
typedef int64 co_int36;
typedef int64 co_int37;
typedef int64 co_int38;
typedef int64 co_int39;
typedef int64 co_int40;
typedef int64 co_int41;
typedef int64 co_int42;
typedef int64 co_int43;
typedef int64 co_int44;
typedef int64 co_int45;
typedef int64 co_int46;
typedef int64 co_int47;
typedef int64 co_int48;
typedef int64 co_int49;
typedef int64 co_int50;
typedef int64 co_int51;
typedef int64 co_int52;
typedef int64 co_int53;
typedef int64 co_int54;
typedef int64 co_int55;
typedef int64 co_int56;
typedef int64 co_int57;
typedef int64 co_int58;
typedef int64 co_int59;
typedef int64 co_int60;
typedef int64 co_int61;
typedef int64 co_int62;
typedef int64 co_int63;
typedef int64 co_int64;
typedef int32 co_int128[4];
typedef int32 co_int256[8];

typedef uint8 co_uint1;
typedef uint8 co_uint2;
typedef uint8 co_uint3;
typedef uint8 co_uint4;
typedef uint8 co_uint5;
typedef uint8 co_uint6;
typedef uint8 co_uint7;
typedef uint8 co_uint8;
typedef uint16 co_uint9;
typedef uint16 co_uint10;
typedef uint16 co_uint11;
typedef uint16 co_uint12;
typedef uint16 co_uint13;
typedef uint16 co_uint14;
typedef uint16 co_uint15;
typedef uint16 co_uint16;
typedef uint32 co_uint17;
typedef uint32 co_uint18;
typedef uint32 co_uint19;
typedef uint32 co_uint20;
typedef uint32 co_uint21;
typedef uint32 co_uint22;
typedef uint32 co_uint23;
typedef uint32 co_uint24;
typedef uint32 co_uint25;
typedef uint32 co_uint26;
typedef uint32 co_uint27;
typedef uint32 co_uint28;
typedef uint32 co_uint29;
typedef uint32 co_uint30;
typedef uint32 co_uint31;
typedef uint32 co_uint32;
typedef uint64 co_uint33;
typedef uint64 co_uint34;
typedef uint64 co_uint35;
typedef uint64 co_uint36;
typedef uint64 co_uint37;
typedef uint64 co_uint38;
typedef uint64 co_uint39;
typedef uint64 co_uint40;
typedef uint64 co_uint41;
typedef uint64 co_uint42;
typedef uint64 co_uint43;
typedef uint64 co_uint44;
typedef uint64 co_uint45;
typedef uint64 co_uint46;
typedef uint64 co_uint47;
typedef uint64 co_uint48;
typedef uint64 co_uint49;
typedef uint64 co_uint50;
typedef uint64 co_uint51;
typedef uint64 co_uint52;
typedef uint64 co_uint53;
typedef uint64 co_uint54;
typedef uint64 co_uint55;
typedef uint64 co_uint56;
typedef uint64 co_uint57;
typedef uint64 co_uint58;
typedef uint64 co_uint59;
typedef uint64 co_uint60;
typedef uint64 co_uint61;
typedef uint64 co_uint62;
typedef uint64 co_uint63;
typedef uint64 co_uint64;
typedef uint32 co_uint128[4];
typedef uint32 co_uint256[8];
# 717 "C:/Impulse/CoDeveloper3/Include/co_math.h"
extern float to_float(uint32 i);
extern double to_double(uint64 i);
extern uint32 float_bits(float f);
extern uint64 double_bits(double f);
# 748 "C:/Impulse/CoDeveloper3/Include/co_math.h"
extern double sqrt (double);
extern double fabs (double);
extern double fmax (double, double);
extern double fmin (double, double);
extern double trunc (double);
extern double floor (double);
extern double ceil (double);
extern double round (double);
extern double scalbn (double, int);





extern float sqrtf (float);
extern float fabsf (float);
extern float fmaxf (float, float);
extern float fminf (float, float);
extern float truncf (float);
extern float floorf (float);
extern float ceilf (float);
extern float roundf (float);
extern float scalbnf (float, int);
# 145 "C:/Impulse/CoDeveloper3/Include/co.h" 2
# 13 "AES_hw.c" 2
# 1 "C:/Impulse/CoDeveloper3/Include/cosim_log.h" 1
# 24 "C:/Impulse/CoDeveloper3/Include/cosim_log.h"
# 1 "C:/Impulse/CoDeveloper3/MinGW/include/stdarg.h" 1 3
# 25 "C:/Impulse/CoDeveloper3/Include/cosim_log.h" 2



typedef struct cosim_logwindow_s* cosim_logwindow;
typedef struct cosim_logstream_s* cosim_logstream;




 int cosim_logwindow_init();



 cosim_logstream cosim_logstream_create(const char * name);
 cosim_logwindow cosim_logwindow_create(const char * name);




 int cosim_logstream_write(cosim_logstream log, const char * msg);
 int cosim_logwindow_write(cosim_logwindow log, const char * msg);


 int cosim_logstream_fwrite(cosim_logstream log, const char * format, ...);
 int cosim_logwindow_fwrite(cosim_logwindow log, const char * format, ...);


 void cosim_logstream_free(cosim_logstream log);
 void cosim_logwindow_free(cosim_logwindow log);
# 14 "AES_hw.c" 2
# 1 "AES.h" 1
# 15 "AES_hw.c" 2

const static co_uint8 SBox[256] = {

 0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
 0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
 0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
 0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
 0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
 0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
 0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
 0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
 0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
 0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
 0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
 0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
 0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
 0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
 0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
 0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16 };





extern void Producer(co_signal AESinputSignal, co_stream AESdataStream);
extern void Consumer(co_stream AESoutputStream);




void AESproc(co_signal AESinputSignal, co_stream AESdataStream, co_stream AESoutputStream)
{
        co_uint32 trigger;
        co_uint32 i, j, k, x;
        co_uint8 streamByte;
        co_uint8 state[4][4];
        co_uint8 stateTemp[4][4];
        co_uint8 expandedKey[11][4][4];
        co_uint32 key[4][4];


        co_signal_wait(AESinputSignal, &trigger);
        co_stream_open(AESdataStream, 0, co_type_create(co_int_sort,8));
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


        co_signal_wait(AESinputSignal, &trigger);
        co_stream_open(AESdataStream, 0, co_type_create(co_int_sort,8));
        i = j = k = 0;
        while (co_stream_read(AESdataStream, &streamByte, sizeof(co_int8)) == co_err_none) {
                expandedKey[i][j][k++] = streamByte;
                if (k == 4)
                {
                        j++;
                        k = 0;
                }
                if (j == 4)
                {
                        i++;
                        j = 0;
                }
        }
        co_stream_close(AESdataStream);


        for (i = 0; i < 4; i++)
        {
                for (j = 0; j < 4; j++)
                {
                        key[i][j] = expandedKey[0][i][j];
                }
        }


        co_signal_wait(AESinputSignal, 0);


        for (i = 0; i < 4; i++) {
                for (j = 0; j < 4; j++) {
                        state[i][j] ^= key[i][j];
                }
        }

        for (j = 1; j <= 10; j++)
        {


                state[0][0] = SBox[state[0][0]];
                state[0][1] = SBox[state[0][1]];
                state[0][2] = SBox[state[0][2]];
                state[0][3] = SBox[state[0][3]];


                x = SBox[state[1][0]];
                state[1][0] = SBox[state[1][1]];
                state[1][1] = SBox[state[1][2]];
                state[1][2] = SBox[state[1][3]];
                state[1][3] = x;


                x = SBox[state[2][0]];
                state[2][0] = SBox[state[2][2]];
                state[2][2] = x;
                x = SBox[state[2][1]];
                state[2][1] = SBox[state[2][3]];
                state[2][3] = x;


                x = SBox[state[3][3]];
                state[3][3] = SBox[state[3][2]];
                state[3][2] = SBox[state[3][1]];
                state[3][1] = SBox[state[3][0]];
                state[3][0] = x;

                if (j != 10)
                {

                        for (i = 0; i <4; i++)
                        {
                                stateTemp[0][i] = ((state[0][i]<<1) ^ ((state[0][i] & 0x80) ? 0x1b : 0x00))^((state[1][i]<<1) ^ ((state[1][i] & 0x80) ? 0x1b : 0x00))^state[1][i]^
                                        state[2][i]^state[3][i];
                                stateTemp[1][i] = state[0][i]^((state[1][i]<<1) ^ ((state[1][i] & 0x80) ? 0x1b : 0x00))^
                                        ((state[2][i]<<1) ^ ((state[2][i] & 0x80) ? 0x1b : 0x00))^state[2][i]^state[3][i];
                                stateTemp[2][i] = state[0][i]^state[1][i]^
                                        ((state[2][i]<<1) ^ ((state[2][i] & 0x80) ? 0x1b : 0x00))^((state[3][i]<<1) ^ ((state[3][i] & 0x80) ? 0x1b : 0x00))^state[3][i];
                                stateTemp[3][i] = ((state[0][i]<<1) ^ ((state[0][i] & 0x80) ? 0x1b : 0x00))^state[0][i]^state[1][i]^
                                        state[2][i]^((state[3][i]<<1) ^ ((state[3][i] & 0x80) ? 0x1b : 0x00));
                        }


                        for (i = 0; i < 4; i++)
                        {
                                for (k = 0; k < 4; k++)
                                {
                                        state[i][k] = stateTemp[i][k];
                                }
                        }
                }


                for (i = 0; i < 4; i++) {
                        for (k = 0; k < 4; k++) {
                                state[i][k] ^= expandedKey[j][i][k];
                        }
                }
        }


        co_stream_open(AESoutputStream, 1, co_type_create(co_int_sort,8));
        for (i = 0; i < 4; i++)
        {
                for (j = 0; j < 4; j++)
                {
                        co_stream_write(AESoutputStream, &state[i][j], sizeof(co_int8));
                }
        }
        co_stream_close(AESoutputStream);
}




void config_AES(void *arg)
{
        co_stream AESdataStream;
        co_stream AESoutputStream;
        co_signal AESinputSignal;

        co_process AESproc_process;
        co_process producer_process;
        co_process consumer_process;

        AESinputSignal = co_signal_create("AESinputSignal");
        AESdataStream = co_stream_create("AESdataStream", co_type_create(co_int_sort,8), 177);
        AESoutputStream = co_stream_create("AESoutputStream", co_type_create(co_int_sort,8), 177);

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


        co_process_config(AESproc_process, co_loc, "pe0");
}

co_architecture co_initialize(int param)
{
        return(co_architecture_create("AES_arch","Generic",config_AES,(void *)param));
}
# 13 "<command line>" 2
# 1 "<stdin>"
