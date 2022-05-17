CC := g++

C_SRCS += \
../src/sender.cpp \
../src/relay.c \
../src/configInterface.c \
../src/main.c 

OBJS += \
./src/sender.o \
./src/relay.o \
./src/configInterface.o

OBJS_DHCP6RELAY += \
./src/main.o 

C_DEPS += \
./src/sender.d \
./src/relay.d \
./src/configInterface.d \
./src/main.d 

src/%.o: src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	$(CC) -D__FILENAME__="$(subst src/,,$<)" $(CFLAGS) $(GCOV_FLAGS) -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '
