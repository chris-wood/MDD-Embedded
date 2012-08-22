#define BIT(d,no) (((d)>>(no))&0x1)
#define MKBIT(d,no) ((d)<<(no))

typedef struct vec64_s {
  unsigned int d1,d0;
} vec64_t;

typedef unsigned int vec_t;

#define LESS_SIGN(x,y,ty) ((ty)(x)<(ty)(y))
#define LESS_EQ_SIGN(x,y,ty) ((ty)(x)<=(ty)(y))
#define GREATER_SIGN(x,y,ty) ((ty)(x)>(ty)(y))
#define GREATER_EQ_SIGN(x,y,ty) ((ty)(x)>=(ty)(y))
#define LESS_UNSIGN(x,y) ((unsigned int)(x)<(unsigned int)(y))
#define LESS_EQ_UNSIGN(x,y) ((unsigned int)(x)<=(unsigned int)(y))
#define GREATER_UNSIGN(x,y) ((unsigned int)(x)>(unsigned int)(y))
#define GREATER_EQ_UNSIGN(x,y) ((unsigned int)(x)>=(unsigned int)(y))
#define LSHIFT_UNSIGN(x,y) ((y)>0 ? ((x)<<(y)) : (x))
#define LSHIFT_SIGN(x,y,ty) ((y)>0 ? ((x)<<(y)) : (x))
#define RSHIFT_UNSIGN(x,y) ((y)>0 ? ((x)>>(y)) : (x))
#define RSHIFT_SIGN(x,y,ty) ((y)>0 ? (((ty)(x))>>(y)) : (x))
#define MUL_SIGN(x,y,ty) (((ty)(x))*(ty)(y))
#define MUL_UNSIGN(x,y,ty) (((ty)(x))*(ty)(y))
#define SIGN8(x) ((char)(x))
#define SIGN16(x) ((short)(x))
#define SIGN32(x) ((int)(x))
#define SIGN64(x) ((long long)(x))
#define EXT_SIGN8(x,y) ((char)((char)(x)<<(y))>>(y))
#define EXT_SIGN16(x,y) ((short)((short)(x)<<(y))>>(y))
#define EXT_SIGN32(x,y) ((((int)(x))<<y)>>y)
#define EXT_SIGN64(x,y) ((((long long)(x))<<y)>>y)

extern ccsvec_copy(vec_t *dst, vec_t *src);
extern vec_t *ccsvec_const(vec_t *dst, int sz, ...);
extern vec_t *ccsvec_import(vec_t *dst, int sz, unsigned long long val);
extern unsigned char ccsvec_bit(vec_t *v, int off);extern void ccsvec_setbit(vec_t *v, int off, unsigned char bit);extern vec_t *ccsvec_slice(vec_t *v, int off, int sz);
extern unsigned long long ccsvec_extract(vec_t *v, int off, int sz);
extern vec_t *ccsvec_extend(vec_t *dst, int sz, unsigned long long val, int extsz);
extern vec_t *ccsvec_cat(vec_t *dst, int no, ...);
extern vec_t *ccsvec_not(vec_t *dst, vec_t *arg);
extern vec_t *ccsvec_neg(vec_t *dst, vec_t *arg);
extern vec_t *ccsvec_abs(vec_t *dst, vec_t *arg);
extern vec_t *ccsvec_sll(vec_t *dst, vec_t *v, int n);
extern vec_t *ccsvec_srl(vec_t *dst, vec_t *v, int n);
extern vec_t *ccsvec_sra(vec_t *dst, vec_t *v, int n);
extern vec_t *ccsvec_rol(vec_t *dst, vec_t *v, int n);
extern vec_t *ccsvec_ror(vec_t *dst, vec_t *v, int n);
extern vec_t *ccsvec_and(vec_t *dst, vec_t *v1, vec_t *v2);
extern vec_t *ccsvec_or(vec_t *dst, vec_t *v1, vec_t *v2);
extern vec_t *ccsvec_xor(vec_t *dst, vec_t *v1, vec_t *v2);
extern vec_t *ccsvec_nand(vec_t *dst, vec_t *v1, vec_t *v2);
extern vec_t *ccsvec_nor(vec_t *dst, vec_t *v1, vec_t *v2);
extern vec_t *ccsvec_xnor(vec_t *dst, vec_t *v1, vec_t *v2);
extern vec_t *ccsvec_add(vec_t *dst, vec_t *v1, vec_t *v2);
extern vec_t *ccsvec_sub(vec_t *dst, vec_t *v1, vec_t *v2);
extern vec_t *ccsvec_mul(vec_t *dst, vec_t *v1, vec_t *v2);
extern vec_t *ccsvec_div(vec_t *dst, vec_t *v1, vec_t *v2);
extern vec_t *ccsvec_mod(vec_t *dst, vec_t *v1, vec_t *v2);
extern int ccsvec_eq(vec_t *v1, vec_t *v2);
extern int ccsvec_neq(vec_t *v1, vec_t *v2);
extern int ccsvec_less(vec_t *v1, vec_t *v2, int issigned);
extern int ccsvec_leq(vec_t *v1, vec_t *v2, int issigned);
extern int ccsvec_greater(vec_t *v1, vec_t *v2, int issigned);
extern int ccsvec_geq(vec_t *v1, vec_t *v2, int issigned);

extern unsigned fadd(unsigned,unsigned);
extern unsigned fsub(unsigned,unsigned);
extern unsigned fmul(unsigned,unsigned);
extern unsigned fdiv(unsigned,unsigned);
extern unsigned feq(unsigned,unsigned);
extern unsigned fneq(unsigned,unsigned);
extern unsigned flt(unsigned,unsigned);
extern unsigned flteq(unsigned,unsigned);
extern unsigned ccs_fsqrt(unsigned a);

extern unsigned long long faddd(unsigned long long,unsigned long long);
extern unsigned long long fsubd(unsigned long long,unsigned long long);
extern unsigned long long fmuld(unsigned long long,unsigned long long);
extern unsigned long long fdivd(unsigned long long,unsigned long long);
extern unsigned long long feqd(unsigned long long,unsigned long long);
extern unsigned long long fneqd(unsigned long long,unsigned long long);
extern unsigned long long fltd(unsigned long long,unsigned long long);
extern unsigned long long flteqd(unsigned long long,unsigned long long);
extern unsigned long long ccs_fsqrtd(unsigned long long a);

extern unsigned itof(unsigned);
extern unsigned utof(unsigned);
extern unsigned ftoi(unsigned);
extern unsigned long long itod(unsigned);
extern unsigned long long utod(unsigned);
extern unsigned dtoi(unsigned long long);
struct _sd_reset_s {
  unsigned char active,event;
  long long last_active,last_event;
  unsigned char last_value;
};
struct _sd_sclk_s {
  unsigned char active,event;
  long long last_active,last_event;
  unsigned char last_value;
};
struct _sd_clk_s {
  unsigned char active,event;
  long long last_active,last_event;
  unsigned char last_value;
};
struct _sd_p_HWinput_rdy_s {
  unsigned char active,event;
  long long last_active,last_event;
  unsigned char last_value;
};
struct _sd_p_HWinput_en_s {
  unsigned char active,event;
  long long last_active,last_event;
  unsigned char last_value;
};
struct _sd_p_HWinput_eos_s {
  unsigned char active,event;
  long long last_active,last_event;
  unsigned char last_value;
};
struct _sd_p_HWinput_data_s {
  unsigned char active,event;
  long long last_active,last_event;
  unsigned int last_value;
};
struct _sd_p_HWoutput_rdy_s {
  unsigned char active,event;
  long long last_active,last_event;
  unsigned char last_value;
};
struct _sd_p_HWoutput_en_s {
  unsigned char active,event;
  long long last_active,last_event;
  unsigned char last_value;
};
struct _sd_p_HWoutput_eos_s {
  unsigned char active,event;
  long long last_active,last_event;
  unsigned char last_value;
};
struct _sd_p_HWoutput_data_s {
  unsigned char active,event;
  long long last_active,last_event;
  unsigned int last_value;
};

enum stateType {stateType_finished,stateType_b3s0,stateType_b2s0,stateType_b1s1,stateType_b1s0,stateType_b0s0,stateType_init};

typedef struct {
  struct _sd_reset_s _sd_reset;
  unsigned char reset;
  struct _sd_sclk_s _sd_sclk;
  unsigned char sclk;
  struct _sd_clk_s _sd_clk;
  unsigned char clk;
  struct _sd_p_HWinput_rdy_s _sd_p_HWinput_rdy;
  unsigned char p_HWinput_rdy;
  struct _sd_p_HWinput_en_s _sd_p_HWinput_en;
  unsigned char p_HWinput_en;
  struct _sd_p_HWinput_eos_s _sd_p_HWinput_eos;
  unsigned char p_HWinput_eos;
  struct _sd_p_HWinput_data_s _sd_p_HWinput_data;
  unsigned int p_HWinput_data;
  struct _sd_p_HWoutput_rdy_s _sd_p_HWoutput_rdy;
  unsigned char p_HWoutput_rdy;
  struct _sd_p_HWoutput_en_s _sd_p_HWoutput_en;
  unsigned char p_HWoutput_en;
  struct _sd_p_HWoutput_eos_s _sd_p_HWoutput_eos;
  unsigned char p_HWoutput_eos;
  struct _sd_p_HWoutput_data_s _sd_p_HWoutput_data;
  unsigned int p_HWoutput_data;
  enum stateType thisState;
  enum stateType nextState;
  unsigned char stateEn;
  unsigned char newState;
  unsigned int r_HWinput;
  unsigned int r_nSample;
  unsigned int ni88_nSample;
  unsigned int ni89_nSample;
  unsigned int r_suif_tmp;
  unsigned int ni87_suif_tmp;
  unsigned char s_b1s0_en;
  unsigned char s_b1s1_en;
  unsigned char s_b2s0_en;
} HWproc_rtl_t;

typedef struct {
  void (*clk_deltap)(HWproc_rtl_t *);
  void (*clk_procp)(HWproc_rtl_t *);
  void (*init_procp)(HWproc_rtl_t *);
  void (*endp)(HWproc_rtl_t *);
  HWproc_rtl_t *data;
} HWproc_rtl_if_t;

static unsigned int mkvec(unsigned char b);
