################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
F90_SRCS += \
../Employee.f90 \
../Main.f90 

O_SRCS += \
../Employee.o 

OBJS += \
./Employee.o \
./Main.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.f90
	@echo 'Building file: $<'
	@echo 'Invoking: GNU Fortran Compiler'
	gfortran -funderscoring -O3 -Wall -c -fmessage-length=0 -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Employee.o: ../Employee.f90

Main.o: ../Main.f90 employeemodule.o


