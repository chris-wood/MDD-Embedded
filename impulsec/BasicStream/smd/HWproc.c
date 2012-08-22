#include <stddef.h>
#include "HWproc.h"

static void _end_cycle(HWproc_rtl_t *_g) {
  _g->_sd_reset.active=0;
  _g->_sd_reset.event=0;
  _g->_sd_reset.last_active++;
  _g->_sd_reset.last_event++;
  _g->_sd_sclk.active=0;
  _g->_sd_sclk.event=0;
  _g->_sd_sclk.last_active++;
  _g->_sd_sclk.last_event++;
  _g->_sd_clk.active=0;
  _g->_sd_clk.event=0;
  _g->_sd_clk.last_active++;
  _g->_sd_clk.last_event++;
  _g->_sd_p_HWinput_rdy.active=0;
  _g->_sd_p_HWinput_rdy.event=0;
  _g->_sd_p_HWinput_rdy.last_active++;
  _g->_sd_p_HWinput_rdy.last_event++;
  _g->_sd_p_HWinput_en.active=0;
  _g->_sd_p_HWinput_en.event=0;
  _g->_sd_p_HWinput_en.last_active++;
  _g->_sd_p_HWinput_en.last_event++;
  _g->_sd_p_HWinput_eos.active=0;
  _g->_sd_p_HWinput_eos.event=0;
  _g->_sd_p_HWinput_eos.last_active++;
  _g->_sd_p_HWinput_eos.last_event++;
  _g->_sd_p_HWinput_data.active=0;
  _g->_sd_p_HWinput_data.event=0;
  _g->_sd_p_HWinput_data.last_active++;
  _g->_sd_p_HWinput_data.last_event++;
  _g->_sd_p_HWoutput_rdy.active=0;
  _g->_sd_p_HWoutput_rdy.event=0;
  _g->_sd_p_HWoutput_rdy.last_active++;
  _g->_sd_p_HWoutput_rdy.last_event++;
  _g->_sd_p_HWoutput_en.active=0;
  _g->_sd_p_HWoutput_en.event=0;
  _g->_sd_p_HWoutput_en.last_active++;
  _g->_sd_p_HWoutput_en.last_event++;
  _g->_sd_p_HWoutput_eos.active=0;
  _g->_sd_p_HWoutput_eos.event=0;
  _g->_sd_p_HWoutput_eos.last_active++;
  _g->_sd_p_HWoutput_eos.last_event++;
  _g->_sd_p_HWoutput_data.active=0;
  _g->_sd_p_HWoutput_data.event=0;
  _g->_sd_p_HWoutput_data.last_active++;
  _g->_sd_p_HWoutput_data.last_event++;
}

static void clk_delta(HWproc_rtl_t *_g)

{

  _g->s_b1s0_en=_g->p_HWinput_rdy;
  _g->s_b1s1_en=_g->p_HWoutput_rdy;
  _g->s_b2s0_en=(_g->p_HWinput_eos & _g->p_HWoutput_rdy);
  _g->ni87_suif_tmp=(((unsigned int)0x0<<1)|(unsigned int)(((0x0<<1)|mkvec(_g->p_HWinput_eos)) == 0x0));
  _g->ni88_nSample=_g->r_HWinput;
  if (_g->thisState == stateType_b1s0) {
    _g->p_HWinput_en=(_g->s_b1s0_en & (!_g->p_HWinput_eos));
  } else if (_g->thisState == stateType_b2s0) {
    _g->p_HWinput_en=(_g->s_b2s0_en | (!_g->p_HWinput_eos));
  } else  {
    _g->p_HWinput_en=0;
  }
  _g->ni89_nSample=(!_g->ni88_nSample);
  switch (_g->thisState) {
  case stateType_init:
    _g->nextState=stateType_b0s0;
    break;
  case stateType_b0s0:
    _g->nextState=stateType_b1s0;
    break;
  case stateType_b1s0:
    if ((!BIT(_g->ni87_suif_tmp,0-0)) == 1) {
      _g->nextState=stateType_b2s0;
    } else  {
      _g->nextState=stateType_b1s1;
    }
    break;
  case stateType_b1s1:
    _g->nextState=stateType_b1s0;
    break;
  case stateType_b2s0:
    _g->nextState=stateType_b0s0;
    break;
  case stateType_b3s0:
    _g->nextState=stateType_finished;
    break;
  case stateType_finished:
    _g->nextState=stateType_finished;
    break;
  default:
    _g->nextState=stateType_init;
    break;
  }
  if (_g->thisState == stateType_b1s0 && _g->s_b1s0_en == 0) {
    _g->stateEn=0;
  } else if (_g->thisState == stateType_b1s1 && _g->s_b1s1_en == 0) {
    _g->stateEn=0;
  } else if (_g->thisState == stateType_b2s0 && _g->s_b2s0_en == 0) {
    _g->stateEn=0;
  } else  {
    _g->stateEn=1;
  }
  if (_g->thisState == stateType_b2s0) {
    _g->p_HWoutput_eos=1;
  } else  {
    _g->p_HWoutput_eos=0;
  }
  _g->p_HWoutput_data=_g->ni89_nSample;
  if (_g->thisState == stateType_b1s1) {
    _g->p_HWoutput_en=_g->s_b1s1_en;
  } else if (_g->thisState == stateType_b2s0) {
    _g->p_HWoutput_en=_g->s_b2s0_en;
  } else  {
    _g->p_HWoutput_en=0;
  }
}

static void clk_proc(HWproc_rtl_t *_g)

{

  if (_g->reset == 1) {
    _g->newState=1;
  } else if (_g->_sd_clk.event && _g->clk == 1) {
    _g->newState=_g->stateEn;
  }
  if (_g->_sd_clk.event && _g->clk == 1) {
    switch (_g->thisState) {
    case stateType_b1s0:
      if (_g->stateEn == 1) {
        _g->r_suif_tmp=_g->ni87_suif_tmp;
      }
      break;
    default:
      break;
    }
  }
  if (_g->_sd_clk.event && _g->clk == 1) {
    switch (_g->thisState) {
    case stateType_b1s1:
      if (_g->stateEn == 1) {
        _g->r_nSample=_g->ni89_nSample;
      }
      break;
    default:
      break;
    }
  }
  if (_g->_sd_clk.event && _g->clk == 1) {
    if ((_g->p_HWinput_en & _g->p_HWinput_rdy) == 1) {
      _g->r_HWinput=_g->p_HWinput_data;
    }
  }
  if (_g->reset == 1) {
    _g->thisState=stateType_init;
  } else if (_g->_sd_clk.event && _g->clk == 1) {
    if (_g->stateEn == 1) {
      _g->thisState=_g->nextState;
    }
  }
}

static void init_proc(HWproc_rtl_t *_g)

{

  _g->s_b1s0_en=_g->p_HWinput_rdy;
  _g->s_b1s1_en=_g->p_HWoutput_rdy;
  _g->s_b2s0_en=(_g->p_HWinput_eos & _g->p_HWoutput_rdy);
  _g->ni87_suif_tmp=(((unsigned int)0x0<<1)|(unsigned int)(((0x0<<1)|mkvec(_g->p_HWinput_eos)) == 0x0));
  switch (_g->thisState) {
  case stateType_init:
    _g->nextState=stateType_b0s0;
    break;
  case stateType_b0s0:
    _g->nextState=stateType_b1s0;
    break;
  case stateType_b1s0:
    if ((!BIT(_g->ni87_suif_tmp,0-0)) == 1) {
      _g->nextState=stateType_b2s0;
    } else  {
      _g->nextState=stateType_b1s1;
    }
    break;
  case stateType_b1s1:
    _g->nextState=stateType_b1s0;
    break;
  case stateType_b2s0:
    _g->nextState=stateType_b0s0;
    break;
  case stateType_b3s0:
    _g->nextState=stateType_finished;
    break;
  case stateType_finished:
    _g->nextState=stateType_finished;
    break;
  default:
    _g->nextState=stateType_init;
    break;
  }
  if (_g->thisState == stateType_b1s0 && _g->s_b1s0_en == 0) {
    _g->stateEn=0;
  } else if (_g->thisState == stateType_b1s1 && _g->s_b1s1_en == 0) {
    _g->stateEn=0;
  } else if (_g->thisState == stateType_b2s0 && _g->s_b2s0_en == 0) {
    _g->stateEn=0;
  } else  {
    _g->stateEn=1;
  }
  _g->ni88_nSample=_g->r_HWinput;
  _g->ni89_nSample=(!_g->ni88_nSample);
  if (_g->thisState == stateType_b2s0) {
    _g->p_HWoutput_eos=1;
  } else  {
    _g->p_HWoutput_eos=0;
  }
  _g->p_HWoutput_data=_g->ni89_nSample;
  if (_g->thisState == stateType_b1s1) {
    _g->p_HWoutput_en=_g->s_b1s1_en;
  } else if (_g->thisState == stateType_b2s0) {
    _g->p_HWoutput_en=_g->s_b2s0_en;
  } else  {
    _g->p_HWoutput_en=0;
  }
  if (_g->thisState == stateType_b1s0) {
    _g->p_HWinput_en=(_g->s_b1s0_en & (!_g->p_HWinput_eos));
  } else if (_g->thisState == stateType_b2s0) {
    _g->p_HWinput_en=(_g->s_b2s0_en | (!_g->p_HWinput_eos));
  } else  {
    _g->p_HWinput_en=0;
  }
  if (_g->reset == 1) {
    _g->thisState=stateType_init;
  } else if (_g->_sd_clk.event && _g->clk == 1) {
    if (_g->stateEn == 1) {
      _g->thisState=_g->nextState;
    }
  }
  if (_g->reset == 1) {
    _g->newState=1;
  } else if (_g->_sd_clk.event && _g->clk == 1) {
    _g->newState=_g->stateEn;
  }
}

HWproc_rtl_if_t *create_HWproc_rtl()

{
  int i;
  HWproc_rtl_if_t *ret;
  HWproc_rtl_t *_g;
  ret=(HWproc_rtl_if_t *)malloc(sizeof(HWproc_rtl_if_t));
  ret->clk_deltap=clk_delta;
  ret->clk_procp=clk_proc;
  ret->init_procp=init_proc;
  ret->endp=_end_cycle;
  ret->data=_g=(HWproc_rtl_t *)malloc(sizeof(HWproc_rtl_t));
  memset(ret->data,0,sizeof(HWproc_rtl_t));
  return(ret);
}

void enum_HWproc_rtl(void (*enump)(), void *arg)
{
  (*enump)(arg,"reset",offsetof(HWproc_rtl_t,reset),sizeof(unsigned char ),1,1,9);
  (*enump)(arg,"_sd_reset",offsetof(HWproc_rtl_t,_sd_reset),sizeof(struct _sd_reset_s),1,1);
  (*enump)(arg,"sclk",offsetof(HWproc_rtl_t,sclk),sizeof(unsigned char ),1,1,9);
  (*enump)(arg,"_sd_sclk",offsetof(HWproc_rtl_t,_sd_sclk),sizeof(struct _sd_sclk_s),1,1);
  (*enump)(arg,"clk",offsetof(HWproc_rtl_t,clk),sizeof(unsigned char ),1,1,9);
  (*enump)(arg,"_sd_clk",offsetof(HWproc_rtl_t,_sd_clk),sizeof(struct _sd_clk_s),1,1);
  (*enump)(arg,"p_HWinput_rdy",offsetof(HWproc_rtl_t,p_HWinput_rdy),sizeof(unsigned char ),1,1,9);
  (*enump)(arg,"_sd_p_HWinput_rdy",offsetof(HWproc_rtl_t,_sd_p_HWinput_rdy),sizeof(struct _sd_p_HWinput_rdy_s),1,1);
  (*enump)(arg,"p_HWinput_en",offsetof(HWproc_rtl_t,p_HWinput_en),sizeof(unsigned char ),1,1,9);
  (*enump)(arg,"_sd_p_HWinput_en",offsetof(HWproc_rtl_t,_sd_p_HWinput_en),sizeof(struct _sd_p_HWinput_en_s),1,1);
  (*enump)(arg,"p_HWinput_eos",offsetof(HWproc_rtl_t,p_HWinput_eos),sizeof(unsigned char ),1,1,9);
  (*enump)(arg,"_sd_p_HWinput_eos",offsetof(HWproc_rtl_t,_sd_p_HWinput_eos),sizeof(struct _sd_p_HWinput_eos_s),1,1);
  (*enump)(arg,"p_HWinput_data",offsetof(HWproc_rtl_t,p_HWinput_data),sizeof(unsigned int ),1,1,-1);
  (*enump)(arg,"_sd_p_HWinput_data",offsetof(HWproc_rtl_t,_sd_p_HWinput_data),sizeof(struct _sd_p_HWinput_data_s),1,1);
  (*enump)(arg,"p_HWoutput_rdy",offsetof(HWproc_rtl_t,p_HWoutput_rdy),sizeof(unsigned char ),1,1,9);
  (*enump)(arg,"_sd_p_HWoutput_rdy",offsetof(HWproc_rtl_t,_sd_p_HWoutput_rdy),sizeof(struct _sd_p_HWoutput_rdy_s),1,1);
  (*enump)(arg,"p_HWoutput_en",offsetof(HWproc_rtl_t,p_HWoutput_en),sizeof(unsigned char ),1,1,9);
  (*enump)(arg,"_sd_p_HWoutput_en",offsetof(HWproc_rtl_t,_sd_p_HWoutput_en),sizeof(struct _sd_p_HWoutput_en_s),1,1);
  (*enump)(arg,"p_HWoutput_eos",offsetof(HWproc_rtl_t,p_HWoutput_eos),sizeof(unsigned char ),1,1,9);
  (*enump)(arg,"_sd_p_HWoutput_eos",offsetof(HWproc_rtl_t,_sd_p_HWoutput_eos),sizeof(struct _sd_p_HWoutput_eos_s),1,1);
  (*enump)(arg,"p_HWoutput_data",offsetof(HWproc_rtl_t,p_HWoutput_data),sizeof(unsigned int ),1,1,-1);
  (*enump)(arg,"_sd_p_HWoutput_data",offsetof(HWproc_rtl_t,_sd_p_HWoutput_data),sizeof(struct _sd_p_HWoutput_data_s),1,1);
  (*enump)(arg,"thisState",offsetof(HWproc_rtl_t,thisState),sizeof(enum stateType ),1,0,7);
  (*enump)(arg,"nextState",offsetof(HWproc_rtl_t,nextState),sizeof(enum stateType ),1,0,7);
  (*enump)(arg,"stateEn",offsetof(HWproc_rtl_t,stateEn),sizeof(unsigned char ),1,0,9);
  (*enump)(arg,"newState",offsetof(HWproc_rtl_t,newState),sizeof(unsigned char ),1,0,9);
  (*enump)(arg,"r_HWinput",offsetof(HWproc_rtl_t,r_HWinput),sizeof(unsigned int ),1,0,-1);
  (*enump)(arg,"r_nSample",offsetof(HWproc_rtl_t,r_nSample),sizeof(unsigned int ),1,0,-1);
  (*enump)(arg,"ni88_nSample",offsetof(HWproc_rtl_t,ni88_nSample),sizeof(unsigned int ),1,0,-1);
  (*enump)(arg,"ni89_nSample",offsetof(HWproc_rtl_t,ni89_nSample),sizeof(unsigned int ),1,0,-1);
  (*enump)(arg,"r_suif_tmp",offsetof(HWproc_rtl_t,r_suif_tmp),sizeof(unsigned int ),1,0,-1);
  (*enump)(arg,"ni87_suif_tmp",offsetof(HWproc_rtl_t,ni87_suif_tmp),sizeof(unsigned int ),1,0,-1);
  (*enump)(arg,"s_b1s0_en",offsetof(HWproc_rtl_t,s_b1s0_en),sizeof(unsigned char ),1,0,9);
  (*enump)(arg,"s_b1s1_en",offsetof(HWproc_rtl_t,s_b1s1_en),sizeof(unsigned char ),1,0,9);
  (*enump)(arg,"s_b2s0_en",offsetof(HWproc_rtl_t,s_b2s0_en),sizeof(unsigned char ),1,0,9);
}

static unsigned int mkvec(unsigned char b_2)
{
  unsigned int res=0x0;

  res=res&~MKBIT(1,0-0)|MKBIT(b_2,0-0);
  return(res);
}

