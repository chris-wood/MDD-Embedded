#include "co.h"
extern void *ccs_alloc_process(void *sim);
extern int Producer(co_stream);
extern void *create_HWproc_rtl();
extern void enum_HWproc_rtl(void (*)(), void *);
extern int Consumer(co_stream);

int HWproc(co_stream HWinput, co_stream HWoutput)
{
  void *proc;

  proc=ccs_alloc_process(create_HWproc_rtl());

  ccs_load_symbols(proc,enum_HWproc_rtl);
  ccs_attach_signals(proc,ccs_stream_reader(HWinput),"p_HWinput",O_RDONLY,1);
  ccs_stream_readable(ccs_stream_reader(HWinput));
  ccs_attach_signals(proc,ccs_stream_writer(HWoutput),"p_HWoutput",O_WRONLY,1);
  ccs_stream_writable(ccs_stream_writer(HWoutput));
  ccs_dbg(proc);
}

static void ccs_config(void *arg)
{
  co_process proc;

  _co_arch_wait_init(1);

  co_stream HWinput;
  co_stream HWoutput;

  HWinput=co_stream_create("HWinput",INT_TYPE(1),2);
  HWoutput=co_stream_create("HWoutput",INT_TYPE(1),2);

  proc=co_process_create("Producer",(co_function)Producer,1,
                    HWinput);
  proc=co_process_create("HWproc",(co_function)HWproc,2,
                    HWinput,
                    HWoutput);
  co_process_config(proc,co_loc,"pe0");
  proc=co_process_create("Consumer",(co_function)Consumer,1,
                    HWoutput);

  ccs_stream_attach(HWinput,O_RDONLY);
  ccs_stream_attach(HWoutput,O_WRONLY);
  ccsdbg_config("BasicStream.smd");

}

co_architecture co_initialize(void *arg)
{
  return(co_architecture_create("BasicStream_arch","Generic",ccs_config,arg));
}
