COMPILER=
ARCHIVER=
CP=cp
COMPILER_FLAGS=
EXTRA_COMPILER_FLAGS=
LIB=libxil.a
LEVEL=0

RELEASEDIR=../../../lib
INCLUDEDIR=../../../include
INCLUDES=-I./. -I${INCLUDEDIR}

L0_INCLUDEFILES=co.h co_if_sim.h co_math.h co_types.h cosim_log.h
L1_INCLUDEFILES=co.h co_if_sim.h co_math.h co_types.h cosim_log.h
LIBSOURCES=*.c
OUTS = *.o 

INCLUDEFILES=$(L$(LEVEL)_INCLUDEFILES)

libs:
	echo "Compiling co_plb"
	$(COMPILER) $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS) $(INCLUDES) $(LIBSOURCES)
	$(ARCHIVER) -r ${RELEASEDIR}/${LIB} ${OUTS} 
	make clean

include: 
	${CP} $(INCLUDEFILES) $(INCLUDEDIR)

clean:
	rm -rf ${OUTS}

