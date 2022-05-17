# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
./test/mock_send.cpp \
./src/relay.cpp \
./src/configInterface.cpp \
./test/MockRelay.cpp

OBJS_DHCP6RELAY_TEST += \
./test/mock_send.o \
./src/relay.o \
./src/configInterface.o \
./test/MockRelay.o

C_DEPS += \
./test/mock_send.d \
./src/relay.d \
./src/configInterface.d \
./test/MockRelay.d

# Each subdirectory must supply rules for building sources it contributes
test/%.o: test/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -std=c++17 -D__FILENAME__="$(subst src/,,$<)" -DBOOST_LOG_DYN_LINK $(INCLUDES) $(CFLAGS) -c -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
