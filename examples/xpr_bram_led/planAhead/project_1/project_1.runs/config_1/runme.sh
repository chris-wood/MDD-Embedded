#!/bin/sh

# 
# PlanAhead(TM)
# runme.sh: a PlanAhead-generated ExploreAhead Script for UNIX
# Copyright 1986-1999, 2001-2010 Xilinx, Inc. All Rights Reserved.
# 

echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\ISE\\bin\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\ISE\\lib\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\common\\bin\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\common\\lib\\nt64
else
  PATH=H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\ISE\\bin\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\ISE\\lib\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\common\\bin\\nt64;H:\\Win7\\Xilinx\\12.3_XPS\\ISE_DS\\common\\lib\\nt64:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD=`dirname "$0"`
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG $* >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep ngdbuild -intstyle ise -p xc6vlx240tff1156-1 -sd "C:\Users\Sam\Downloads\xpr_chris_project\xpr_bram_led\planAhead\project_1\project_1.srcs\sources_1\imports" -uc "config_1.ucf" "config_1.edf"
EAStep map -intstyle ise -w "config_1.ngd"
EAStep par -intstyle ise "config_1.ncd" -w "config_1_routed.ncd"
EAStep trce -intstyle ise -o "config_1.twr" -v 30 -l 30 "config_1_routed.ncd" "config_1.pcf"
EAStep xdl -secure -ncd2xdl -nopips "config_1_routed.ncd" "config_1_routed.xdl"
