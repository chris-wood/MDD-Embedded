################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/HelloWorld.c \
../src/HelloWorld_sw.c \
../src/co_init.c \
../src/co_memory.c \
../src/co_process.c \
../src/co_register.c \
../src/co_signal.c \
../src/co_stream.c \
../src/co_type.c \
../src/main.c \
../src/platform.c 

OBJS += \
./src/HelloWorld.o \
./src/HelloWorld_sw.o \
./src/co_init.o \
./src/co_memory.o \
./src/co_process.o \
./src/co_register.o \
./src/co_signal.o \
./src/co_stream.o \
./src/co_type.o \
./src/main.o \
./src/platform.o 

C_DEPS += \
./src/HelloWorld.d \
./src/HelloWorld_sw.d \
./src/co_init.d \
./src/co_memory.d \
./src/co_process.d \
./src/co_register.d \
./src/co_signal.d \
./src/co_stream.d \
./src/co_type.d \
./src/main.d \
./src/platform.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: PowerPC gcc compiler'
	powerpc-eabi-gcc -Wall -O0 -g3 -I"C:\Workspace\ImpulseIntegrationSystem\ppc440_0\include" -I"C:\Workspace\ImpulseIntegrationSystem\drivers\plb_HelloWorldArch_v1_00_a\src" -c -fmessage-length=0 -D __XMK__ -I../../xilkernel_bsp_0/ppc440_0/include -mcpu=440 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


