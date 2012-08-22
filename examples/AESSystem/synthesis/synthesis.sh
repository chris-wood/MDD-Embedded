#!/bin/bash

rm -rf xst

echo "xst -ifn "plb_bubblesort_arch_0_wrapper_xst.scr" -intstyle silent"

echo "Running XST synthesis ..."

xst -ifn "plb_bubblesort_arch_0_wrapper_xst.scr" -intstyle silent
if [ $? -ne 0 ]; then
	exit 1
fi

echo "XST completed"

rm -rf xst

echo "xst -ifn "plb_bubblesort_arch_1_wrapper_xst.scr" -intstyle silent"

echo "Running XST synthesis ..."

xst -ifn "plb_bubblesort_arch_1_wrapper_xst.scr" -intstyle silent
if [ $? -ne 0 ]; then
	exit 1
fi

echo "XST completed"

rm -rf xst

echo "xst -ifn "plb_bubblesort_arch_2_wrapper_xst.scr" -intstyle silent"

echo "Running XST synthesis ..."

xst -ifn "plb_bubblesort_arch_2_wrapper_xst.scr" -intstyle silent
if [ $? -ne 0 ]; then
	exit 1
fi

echo "XST completed"

rm -rf xst

echo "xst -ifn "plb_bubblesort_arch_3_wrapper_xst.scr" -intstyle silent"

echo "Running XST synthesis ..."

xst -ifn "plb_bubblesort_arch_3_wrapper_xst.scr" -intstyle silent
if [ $? -ne 0 ]; then
	exit 1
fi

echo "XST completed"

rm -rf xst

echo "xst -ifn "plb_bubblesort_arch_4_wrapper_xst.scr" -intstyle silent"

echo "Running XST synthesis ..."

xst -ifn "plb_bubblesort_arch_4_wrapper_xst.scr" -intstyle silent
if [ $? -ne 0 ]; then
	exit 1
fi

echo "XST completed"

rm -rf xst

echo "xst -ifn "plb_aes_arch_0_wrapper_xst.scr" -intstyle silent"

echo "Running XST synthesis ..."

xst -ifn "plb_aes_arch_0_wrapper_xst.scr" -intstyle silent
if [ $? -ne 0 ]; then
	exit 1
fi

echo "XST completed"

rm -rf xst

echo "xst -ifn "system_xst.scr" -intstyle silent"

echo "Running XST synthesis ..."

xst -ifn "system_xst.scr" -intstyle silent
if [ $? -ne 0 ]; then
  exit 1
fi

echo "XST completed"

rm -rf xst

mv ../implementation/system.ngc .
ngcbuild ./system.ngc ../implementation/system.ngc -sd ../implementation -i
if [ $? -ne 0 ]; then
  exit 1
fi
