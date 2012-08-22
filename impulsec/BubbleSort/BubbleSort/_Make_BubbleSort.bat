@ECHO OFF
set PATH=%IMPULSEC_HOME%\bin;%IMPULSEC_GCC_HOME%\bin;%PATH%;
set IMPULSEC_HOME=C:/Impulse/CoDeveloper3
set IMPULSEC_GCC_HOME=%IMPULSEC_HOME%/MinGW
"C:\Impulse\CoDeveloper3\bin\make.exe" SHELL=C:/Impulse/CoDeveloper3/bin/sh.exe -f"C:\Workspace\repo\impulsec\BubbleSort\BubbleSort\_Makefile" export_hardware
echo 1 > "CoDeveloper.log.done"
