################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include src/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
ELFSIZE += \
xilkernel_posix_threads_demo_0.elf.size \

ELFCHECK += \
xilkernel_posix_threads_demo_0.elf.elfcheck \


# All Target
all: xilkernel_posix_threads_demo_0.elf secondary-outputs

# Tool invocations
xilkernel_posix_threads_demo_0.elf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: PowerPC gcc linker'
	powerpc-eabi-gcc -L"C:\Workspace\ImpulseSystem\drivers\plb_BasicStream_arch_v1_00_a\src" -Wl,-T -Wl,../src/lscript.ld -L../../xilkernel_bsp_0/ppc440_0/lib -mcpu=440 -o"xilkernel_posix_threads_demo_0.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

xilkernel_posix_threads_demo_0.elf.size: xilkernel_posix_threads_demo_0.elf
	@echo 'Invoking: PowerPC Print Size'
	powerpc-eabi-size xilkernel_posix_threads_demo_0.elf  |tee "xilkernel_posix_threads_demo_0.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

xilkernel_posix_threads_demo_0.elf.elfcheck: xilkernel_posix_threads_demo_0.elf
	@echo 'Invoking: Xilinx ELF Check'
	elfcheck xilkernel_posix_threads_demo_0.elf -hw ../../hw_platform_0/system.xml -pe ppc440_0  |tee "xilkernel_posix_threads_demo_0.elf.elfcheck"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(C_DEPS)$(EXECUTABLES)$(ELFSIZE)$(ELFCHECK)$(S_UPPER_DEPS) xilkernel_posix_threads_demo_0.elf
	-@echo ' '

secondary-outputs: $(ELFSIZE) $(ELFCHECK)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
